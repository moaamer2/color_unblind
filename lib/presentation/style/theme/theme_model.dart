import 'package:flutter/material.dart';
import 'color_collection_model.dart';

class AppTheme {
  final ColorCollection colorCollection;

  AppTheme({required this.colorCollection});

  Color get backgroundColor => colorCollection.backgroundColor;
  Color get primaryColor => colorCollection.primaryColor;
  Color get secondaryColor => colorCollection.secondaryColor;
  Color get textColor => colorCollection.textColor;
  Color get borderColor => colorCollection.borderColor;
  Color get shadowColor => colorCollection.shadowColor;
  Color get nonActiveColor => colorCollection.nonActiveColor;
  Color get cardColor => colorCollection.cardColor;
}