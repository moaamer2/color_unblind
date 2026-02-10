import 'package:colors_blind/module/enums/processing_type.dart';
import 'package:colors_blind/module/models/color_blind_type.dart';

class SendFrameParams {
  final ColorBlindType colorBlindType;
  final double brightness;
  final ProcessingType processingType;

  SendFrameParams({required this.colorBlindType, required this.brightness, required this.processingType});
}