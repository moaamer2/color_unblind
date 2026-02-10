import 'package:colors_blind/module/enums/processing_type.dart';
import 'package:colors_blind/module/models/color_blind_type.dart';

class SendFramesLocalDataSourceParams {
  final ColorBlindType colorBlindType;
  final double brightness;
  final ProcessingType processingType;
  
  SendFramesLocalDataSourceParams({
    required this.colorBlindType,
    required this.brightness,
    required this.processingType,
  });
}
