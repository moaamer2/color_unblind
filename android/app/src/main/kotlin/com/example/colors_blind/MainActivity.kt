package com.example.colors_blind

import android.graphics.BitmapFactory
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import org.tensorflow.lite.Interpreter
import org.tensorflow.lite.support.common.FileUtil

class MainActivity : FlutterActivity() {
    private val MODEL_CHANNEL = "com.your-company.custom-model/channel"
    private var interpreter: Interpreter? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, MODEL_CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "runModel") {
                    try {
                        Log.d("ModelDebug", "runModel invoked")
                        println("ModelDebug: runModel invoked")
                        val args = call.arguments as Map<*, *>
                        Log.d("ModelDebug", "args keys: ${args.keys}")
                        val list = args["params"] as? List<*>
                            ?: throw IllegalArgumentException("params is not a List")
                        Log.d("ModelDebug", "params length: ${list.size}")

                        // Extract metadata (Dart: first=brightness, second=type)
                        if (list.size < 3) throw IllegalArgumentException("params must have at least 3 elements")
                        val brightness = (list[0] as Number).toFloat()
                        val type = (list[1] as Number).toFloat()
                        Log.d("ModelDebug", "brightness=$brightness type=$type")
                        println("ModelDebug: brightness=$brightness type=$type")

                        // The remaining data is frame bytes
                        val frameListAny = list.drop(2)
                        if (frameListAny.isEmpty()) throw IllegalArgumentException("frame data is empty")
                        val frameList = frameListAny.map {
                            when (it) {
                                is Number -> it.toDouble()
                                else -> throw IllegalArgumentException("frame item not a Number: ${it?.javaClass}")
                            }
                        }
                        Log.d("ModelDebug", "frame bytes count: ${frameList.size}")
                        println("ModelDebug: frame bytes count=${frameList.size}")

                        // Convert List<Double> -> ByteArray
                        val jpegBytes = ByteArray(frameList.size) { i ->
                            frameList[i].toInt().toByte()
                        }

                        // Decode JPEG to Bitmap
                        val bitmap = BitmapFactory.decodeByteArray(jpegBytes, 0, jpegBytes.size)
                            ?: throw IllegalArgumentException("Failed to decode JPEG")
                        Log.d("ModelDebug", "decoded bitmap: ${bitmap.width}x${bitmap.height}")
                        println("ModelDebug: decoded bitmap ${bitmap.width}x${bitmap.height}")

                        // Extract pixels
                        val width = bitmap.width
                        val height = bitmap.height
                        val pixels = IntArray(width * height)
                        bitmap.getPixels(pixels, 0, width, 0, 0, width, height)

                        // Convert to FloatArray RGB (0..1)
                        val rgbFloats = FloatArray(pixels.size * 3)
                        for (i in pixels.indices) {
                            val px = pixels[i]
                            rgbFloats[i * 3]     = ((px shr 16) and 0xFF) / 255f // R
                            rgbFloats[i * 3 + 1] = ((px shr 8) and 0xFF) / 255f  // G
                            rgbFloats[i * 3 + 2] = (px and 0xFF) / 255f          // B
                        }

                        // Load TFLite model once
                        if (interpreter == null) {
                            val model = FileUtil.loadMappedFile(this, "color.tflite")
                            interpreter = Interpreter(model)
                            Log.d("ModelDebug", "Model loaded successfully")
                            println("ModelDebug: model loaded")
                        }

                        // Inspect expected tensor shapes
                        val in0 = interpreter!!.getInputTensor(0).shape()
                        val in1 = interpreter!!.getInputTensor(1).shape()
                        val in2 = interpreter!!.getInputTensor(2).shape()
                        val out0 = interpreter!!.getOutputTensor(0).shape()
                        val inCount = interpreter!!.inputTensorCount
                        val outCount = interpreter!!.outputTensorCount

                        Log.d("ModelDebug", "Input0 shape: ${in0.contentToString()}")
                        Log.d("ModelDebug", "Input1 shape: ${in1.contentToString()}")
                        Log.d("ModelDebug", "Input2 shape: ${in2.contentToString()}")
                        Log.d("ModelDebug", "Output0 shape: ${out0.contentToString()}")
                        Log.d("ModelDebug", "inputCount=$inCount outputCount=$outCount")
                        println("ModelDebug: Input0=${in0.contentToString()} Input1=${in1.contentToString()} Input2=${in2.contentToString()} Output0=${out0.contentToString()}")

                        val pixelCount = rgbFloats.size / 3

                        // Model expects inputs with shapes: input0=[1,1] (brightness), input1=[1,1] (type), input2=[1,3] (RGB)
                        // We'll run per-pixel and accumulate outputs.
                        val results = ArrayList<List<Double>>(pixelCount)
                        for (i in 0 until pixelCount) {
                            val r = rgbFloats[i * 3]
                            val g = rgbFloats[i * 3 + 1]
                            val b = rgbFloats[i * 3 + 2]

                            val brightnessInput = arrayOf(floatArrayOf(brightness))   // [1,1]
                            val typeInput = arrayOf(floatArrayOf(type))               // [1,1]
                            val pixelInput = arrayOf(floatArrayOf(r, g, b))           // [1,3]

                            val outputOne = Array(1) { FloatArray(3) }                // [1,3]

                            try {
                                interpreter!!.runForMultipleInputsOutputs(
                                    arrayOf(brightnessInput, typeInput, pixelInput),
                                    mapOf(0 to outputOne)
                                )
                            } catch (e: Exception) {
                                Log.e("ModelDebug", "Inference failed at pixel index=$i", e)
                                println("ModelDebug: inference failed at $i: ${e.message}")
                                throw e
                            }

                            val o = outputOne[0]
                            results.add(listOf(o[0].toDouble(), o[1].toDouble(), o[2].toDouble()))
                        }

                        val finalResult = results

                        result.success(finalResult)
                    } catch (e: Exception) {
                        Log.e("ModelDebug", "Exception in runModel", e)
                        println("ModelDebug: exception ${e.message}")
                        result.error("MODEL_ERROR", "Failed to run model: ${e.message}", e.stackTraceToString())
                    }
                } else {
                    result.notImplemented()
                }
            }
    }
}
