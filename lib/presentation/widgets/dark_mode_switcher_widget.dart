import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/presentation/style/app_colors.dart';
import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DarkModeSwitcherWidget extends StatelessWidget {
  const DarkModeSwitcherWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    bool isrtl = Directionality.of(context) == TextDirection.rtl;

    return Transform.flip(
      flipX: isrtl,
      child: Row(
        spacing: 2,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // light icon
          Icon(
            Icons.light_mode,
            color: themeCubit.state.textColor,
            size: 20.textScale,
          ),
      
          // switch
          Switch.adaptive(
            value: themeCubit.isDark,
            focusColor: themeCubit.state.primaryColor,
            activeThumbColor: AppColors.white,
            activeTrackColor: themeCubit.state.primaryColor,
            inactiveThumbColor: themeCubit.state.textColor,
            inactiveTrackColor: themeCubit.state.backgroundColor,
            onChanged: (value){
              themeCubit.toggleTheme(value);
            },
          ),
      
          // dark icon
          Transform.flip(
            flipX: isrtl,
            child: Icon(
              Icons.dark_mode,
              color: themeCubit.state.textColor,
              size: 20.textScale,
            ),
          ),
        ],
      ),
    );
  }
}