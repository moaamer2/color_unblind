import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/core/services/localization/locale_keys.g.dart';
import 'package:colors_blind/presentation/style/app_colors.dart';
import 'package:colors_blind/presentation/style/app_fonts.dart';
import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';

class NoDataCustomWigdet extends StatelessWidget {
  final String massage;
  final void Function()? reTry;
  const NoDataCustomWigdet({
    super.key,
    required this.massage,
    this.reTry
  });



  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // no data icon 
        Icon(
          FontAwesomeIcons.xmark,
          color: themeCubit.state.primaryColor,
          size: 100.fromRadius.max(150),
        ),
    
        // space between
        SizedBox(height: 10.fromHeight,),
    
        // no data text
        Text(
          context.tr(LocaleKeys.noData),
          style: TextStyle(
            color: themeCubit.state.textColor,
            fontSize: 16.fromRadius.max(25),
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.montserrat,
          ),
        ),
    
        // massage text and reTry button
        Row(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // massage text
            Text(
              massage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.darkGrey,
                fontSize: 14.fromRadius.max(20),
                fontWeight: FontWeight.bold,
              ),
            ),

            // reTry button
            reTry == null ? const SizedBox.shrink() : GestureDetector(
              onTap: reTry,
              child: Icon(
                Icons.refresh_rounded,
                color: themeCubit.state.primaryColor,
                size: 18.fromRadius.max(22),
              ),
            ),
          ],
        ),
      ],
    );
  }
}