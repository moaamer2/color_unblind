import 'package:colors_blind/module/models/color_blind_type.dart';

class GenerateImageParams {
  final String description;
  final ColorBlindType colorBlindType;

  GenerateImageParams({
    required this.description,
    required this.colorBlindType,
  });


  Map<String, dynamic> get json => {
    'textDescription': description,
    'colorBlindType': colorBlindType.value,
  };
}