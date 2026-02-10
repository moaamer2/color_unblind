import 'package:colors_blind/core/data/local/params/send_frames_local_data_source_params.dart';

abstract class LocalDataSource {
  Future<List<double>> getFilterMatrix(SendFramesLocalDataSourceParams params);
}