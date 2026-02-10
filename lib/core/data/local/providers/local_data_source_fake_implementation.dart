import 'dart:async';
import 'package:colors_blind/core/data/local/local_data_source.dart';
import 'package:colors_blind/core/data/local/params/send_frames_local_data_source_params.dart';

class LocalDataSourceFakeImplementation implements LocalDataSource {
  @override
  Future<List<double>> getFilterMatrix(SendFramesLocalDataSourceParams params) async {
    // TODO: implement getFilterMatrix
    throw UnimplementedError();
  }
}
