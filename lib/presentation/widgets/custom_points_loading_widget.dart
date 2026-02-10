import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/core/services/localization/locale_keys.g.dart';
import 'package:colors_blind/presentation/style/app_colors.dart';
import 'package:colors_blind/presentation/style/app_fonts.dart';
import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';
import 'package:colors_blind/presentation/widgets/points_loading_widget_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomPointsLoadingWidget extends StatelessWidget {
  const CustomPointsLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return Row(
      spacing: 10.staticWidth,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // loading text
        Text(
          context.tr(LocaleKeys.loading,),
          style: TextStyle(
            color: themeCubit.state.textColor,
            fontSize: 18.textScale,
            fontFamily: AppFonts.montserrat,
          ),
        ),
    
        // loading indicators 
        PointsLoadingWidgetIndicator(
          color: themeCubit.state.primaryColor,
          shadingColor: AppColors.grey,
          size: 12.fromRadius.max(20),
          countIndicators: 4,
        ),
      ],
    );
  }
}
