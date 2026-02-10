import 'dart:async';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

abstract interface class ImageConverter {
  /// Convert CameraImage to JPEG bytes (Uint8List)
  static Uint8List convertToUint8List(CameraImage image) {
    if (image.format.group == ImageFormatGroup.bgra8888) {
      // Already raw BGRA bytes; wrap in JPEG for smaller transfer
      final imgBuffer = img.Image.fromBytes(
        width: image.width,
        height: image.height,
        bytes: image.planes[0].bytes.buffer,
        order: img.ChannelOrder.bgra,
      );
      return Uint8List.fromList(img.encodeJpg(imgBuffer));
    } 
    else if (image.format.group == ImageFormatGroup.yuv420) {
      final int width = image.width;
      final int height = image.height;
      final img.Image imgBuffer = img.Image(width: width, height: height);

      final Uint8List y = image.planes[0].bytes;
      final Uint8List u = image.planes[1].bytes;
      final Uint8List v = image.planes[2].bytes;

      final int uvRowStride = image.planes[1].bytesPerRow;
      final int uvPixelStride = image.planes[1].bytesPerPixel!;

      for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
          final int uvIndex = uvPixelStride * (w ~/ 2) + uvRowStride * (h ~/ 2);
          final int yIndex = h * width + w;

          final int yp = y[yIndex] & 0xFF;
          final int up = u[uvIndex] & 0xFF;
          final int vp = v[uvIndex] & 0xFF;

          int r = (yp + 1.403 * (vp - 128)).toInt();
          int g = (yp - 0.344 * (up - 128) - 0.714 * (vp - 128)).toInt();
          int b = (yp + 1.770 * (up - 128)).toInt();

          r = r.clamp(0, 255);
          g = g.clamp(0, 255);
          b = b.clamp(0, 255);

          imgBuffer.setPixelRgb(w, h, r, g, b);
        }
      }

      // Encode as JPEG for memory efficiency
      return Uint8List.fromList(img.encodeJpg(imgBuffer));
    } 
    else {
      throw UnsupportedError("Image format ${image.format.group} not supported");
    }
  }

  static Future<ui.Image> convertToImage(Uint8List bytes, {required int width, required int height}) async {
    final completer = Completer<ui.Image>();
    ui.decodeImageFromPixels(
      bytes,
      width,
      height,
      ui.PixelFormat.rgba8888, // must match bytes length = width*height*4
      (ui.Image img) => completer.complete(img),
    );
    return completer.future;
  }
}

// 2 -> 6
// 12 -> 3
