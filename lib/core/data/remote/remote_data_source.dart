import 'package:colors_blind/core/data/remote/params/process_image_data_source_params.dart';
import 'package:colors_blind/core/data/remote/params/send_frame_remote_data_source_params.dart';
import 'package:colors_blind/module/repo/params/generate_image_params.dart';
import 'package:flutter/services.dart';

abstract class RemoteDataSource {
  Future<Uint8List> sendFrame(SendFrameRemoteDataSourceParams params);


  Future<String> processImage(ProcessDataSourceImageParams params);


  Future<String> generateImageParams(GenerateImageParams params);
}
