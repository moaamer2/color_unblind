import 'package:colors_blind/core/data/local/local_data_source.dart';
import 'package:colors_blind/core/data/local/params/send_frames_local_data_source_params.dart';
import 'package:flutter/services.dart';

class LocalDataSourceNativeAiImplementation implements LocalDataSource {
  // ignore: unused_field
  final _modelChannel = MethodChannel('com.your-company.custom-model/channel');

  // ignore: unused_element
  double _normalizedBrightness(double brightness) {
    // Normalize brightness from 0-100 to 0.0-1.0
    return brightness.clamp(0, 100) / 100.0;
  }
  
  @override
  Future<List<double>> getFilterMatrix(SendFramesLocalDataSourceParams params) {
    // TODO: implement getFilterMatrix
    throw UnimplementedError();
  }
}
