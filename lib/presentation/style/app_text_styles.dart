import 'package:flutter/material.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/presentation/style/app_colors.dart';
import 'package:colors_blind/presentation/style/app_fonts.dart';

abstract interface class AppTextStyles {
  static TextStyle appBarTitle = TextStyle(
    fontFamily: AppFonts.impact,
    fontSize: 26.fromRadius.max(40),
  );

  static TextStyle buttonTextStyle = TextStyle(
    color: AppColors.white,
    fontSize: 14.textScale,
    fontWeight: FontWeight.bold,
  );

  static TextStyle progressIndicatorStyle = TextStyle(
    fontSize: 25.textScale,
    fontWeight: FontWeight.bold,
    fontFamily: AppFonts.impact,
  );
}