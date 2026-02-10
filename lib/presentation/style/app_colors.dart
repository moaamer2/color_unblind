import 'package:flutter/material.dart';

abstract interface class AppColors {
  // basic colors
  static Color white = const Color.fromARGB(255, 255, 255, 255);
  static Color grey = const Color(0xffd4d4d4);
  static Color veryLightBlack = const Color(0xff333333);
  static Color veryLightGrey = const Color.fromARGB(179, 233, 239, 245);
  static Color darkGrey = const Color.fromARGB(255, 158, 158, 158);
  static Color darkWhite = const Color.fromARGB(255, 186, 186, 186);
  static const Color moreDarkGrey = Color.fromARGB(255, 117, 117, 117);
  static Color green = const Color.fromARGB(255, 78, 177, 81);
  static Color red = const Color.fromARGB(255, 255, 17, 0);
  static Color transparent = const Color.fromARGB(0, 255, 255, 255);
  static Color yellow = Colors.amber;
  

  // green colors
  static Color darkGreen = const Color(0xff2b8c58);
  static Color hellGreen = const Color.fromARGB(255, 240, 255, 248);
  static Color hellGreenOpacity = const Color.fromARGB(192, 161, 255, 205);
  static Color darkGreenOpacity = const Color.fromARGB(255, 190, 255, 221);
  static Color darkHellGreenOpacity = const Color.fromARGB(113, 74, 255, 159);
}
