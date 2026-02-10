import 'package:flutter/material.dart';
import 'package:colors_blind/presentation/style/app_colors.dart';

class ColorCollection {
  final Color backgroundColor;
  final Color primaryColor;
  final Color secondaryColor;
  final Color textColor;
  final Color borderColor;
  final Color shadowColor;
  final Color nonActiveColor;
  final Color cardColor;

  ColorCollection({
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.grey,
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.grey,
    this.textColor = Colors.black,
    this.shadowColor = Colors.grey,
    this.nonActiveColor = Colors.grey,
    this.cardColor = Colors.grey,
  });

  factory ColorCollection.defaultLightCollection(){
    return ColorCollection(
      primaryColor: AppColors.darkGreen,
      secondaryColor: AppColors.hellGreen,
      backgroundColor: AppColors.white,
      textColor: AppColors.veryLightBlack,
      shadowColor: AppColors.grey,
      nonActiveColor: AppColors.hellGreenOpacity,
      cardColor: AppColors.veryLightGrey,
    );
  }

  factory ColorCollection.defaultDarkCollection(){
    return ColorCollection(
      primaryColor: AppColors.darkGreen,
      secondaryColor: AppColors.darkGreenOpacity,
      backgroundColor: AppColors.veryLightBlack,
      textColor: AppColors.white,
      shadowColor: AppColors.darkWhite,
      nonActiveColor: AppColors.darkHellGreenOpacity,
      cardColor: AppColors.moreDarkGrey,
    );
  }

  ColorCollection copyWith({
    Color? backgroundColor,
    Color? primaryColor,
    Color? secondaryColor,
    Color? textColor,
    Color? borderColor,
    Color? shadowColor,
    Color? nonActiveColor,
    Color? cardColor
  }) {
    return ColorCollection(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      textColor: textColor ?? this.textColor,
      borderColor: borderColor ?? this.borderColor,
      shadowColor: shadowColor ?? this.shadowColor,
      nonActiveColor: nonActiveColor ?? this.nonActiveColor,
      cardColor: cardColor ?? this.cardColor,
    );
  }
}