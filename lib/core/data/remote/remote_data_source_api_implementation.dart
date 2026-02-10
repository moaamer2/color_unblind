import 'dart:typed_data';

import 'package:colors_blind/core/data/remote/api/restful_api_end_points.dart';
import 'package:colors_blind/core/data/remote/api/restful_api_handler.dart';
import 'package:colors_blind/core/data/remote/params/process_image_data_source_params.dart';
import 'package:colors_blind/core/data/remote/params/send_frame_remote_data_source_params.dart';
import 'package:colors_blind/core/data/remote/remote_data_source.dart';
import 'package:colors_blind/module/repo/params/generate_image_params.dart';

class RemoteDataSourceApiImplementation implements RemoteDataSource {
  final RestfulApiHandler _restfulApiHandler;

  RemoteDataSourceApiImplementation(this._restfulApiHandler);

  @override
  Future<String> generateImageParams(GenerateImageParams params) async {
    final response = await _restfulApiHandler.post(
      endpoint: RestfulApiEndPoints.imageGeneration,
      body: params.json,
    );


    return response.data['resultImageUrl'];
  }

  @override
  Future<String> processImage(ProcessDataSourceImageParams params) async {
    final response = await _restfulApiHandler.post(
      endpoint: RestfulApiEndPoints.imageProcessing,
      body: params.json,
    );


    return response.data['resultImageUrl'];
  }

  @override
  Future<Uint8List> sendFrame(SendFrameRemoteDataSourceParams params) async {
    await Future.delayed(const Duration(microseconds: 1,));

    // 🔹 Step 1: Extract raw bytes (assumes BGRA8888 format)
    final Uint8List inputBytes = params.frame;

    // 🔹 Step 2: Invert colors (leave alpha as-is)
    final Uint8List outputBytes = Uint8List(inputBytes.length);
    for (int i = 0; i < inputBytes.length; i += 4) {
      outputBytes[i]     = 255 - inputBytes[i];     // B
      if (i + 1 < inputBytes.length) outputBytes[i + 1] = 255 - inputBytes[i + 1]; // G
      if (i + 2 < inputBytes.length) outputBytes[i + 2] = 255 - inputBytes[i + 2]; // R
      if (i + 3 < inputBytes.length) outputBytes[i + 3] = inputBytes[i + 3];       // A
    }

    return outputBytes;
  }
}