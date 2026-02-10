import 'dart:io';
import 'package:colors_blind/module/models/color_blind_type.dart';

class ProcessImageParams {
  final File image;
  final ColorBlindType colorBlindType;

  ProcessImageParams({
    required this.image,
    required this.colorBlindType,
  });
}