import 'package:colors_blind/module/models/color_blind_type.dart';

class ProcessDataSourceImageParams {
  final String imageURL;
  final ColorBlindType colorBlindType;

  ProcessDataSourceImageParams({
    required this.imageURL,
    required this.colorBlindType,
  });


  Map<String, dynamic> get json => {
    'imageUrl': imageURL,
    'colorBlindType': colorBlindType.value
  };
}