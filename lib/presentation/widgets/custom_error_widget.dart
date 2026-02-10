import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/core/services/localization/locale_keys.g.dart';
import 'package:colors_blind/presentation/style/app_colors.dart';
import 'package:colors_blind/presentation/style/app_fonts.dart';
import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';

class CustomErrorWigdet extends StatelessWidget {
  final String massage;
  const CustomErrorWigdet({
    super.key,
    required this.massage,
  });



  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // no data icon 
        Icon(
          Icons.error_rounded,
          color: AppColors.red,
          size: 100.fromRadius,
        ),
    
        // space between
        SizedBox(height: 10.fromHeight,),
    
        // no data text
        Text(
          context.tr(LocaleKeys.error),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: themeCubit.state.textColor,
            fontSize: 16.textScale,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.montserrat,
          ),
        ),
    
        // massage text
        Text(
          massage,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.darkGrey,
            fontSize: 14.textScale,
            fontWeight: FontWeight.normal,
            fontFamily: AppFonts.montserrat,
          ),
        )
      ],
    );
  }
}