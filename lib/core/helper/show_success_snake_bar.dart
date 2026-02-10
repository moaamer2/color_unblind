import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:colors_blind/core/extensions/context/showing.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'get_snake_bar.dart';
import 'package:colors_blind/presentation/style/app_colors.dart';
import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';

void showSuccessSnakeBar(BuildContext context, String message) {
  context.showSnackBar(
    snackBar: getSnackBar(
      iconColor: context.read<ThemeCubit>().state.primaryColor,
      backgroundColor: context.read<ThemeCubit>().state.backgroundColor,
      message: context.tr(message),
      endIcon: Icon(
        Icons.verified_user_rounded,
        color: AppColors.green,
        size: 25.textScale,
      ),
    ),
  );
}
