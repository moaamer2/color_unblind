import 'package:colors_blind/module/models/color_blind_type.dart';
import 'package:flutter/services.dart';

class SendFrameRemoteDataSourceParams {
  final Uint8List frame;
  final ColorBlindType colorBlindType;
  final double brightness;

  SendFrameRemoteDataSourceParams({
    required this.frame,
    required this.colorBlindType,
    required this.brightness,
  });
}