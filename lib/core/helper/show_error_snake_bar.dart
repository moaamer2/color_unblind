import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:colors_blind/core/error/failure.dart';
import 'package:colors_blind/core/extensions/context/showing.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'get_snake_bar.dart';
import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';

void showErrorSnakeBar(BuildContext context, Failure failure) {
  return context.showSnackBar(
    snackBar: getSnackBar(
      iconColor: context.read<ThemeCubit>().state.primaryColor,
      message: context.tr(failure.message),
      backgroundColor: context.read<ThemeCubit>().state.backgroundColor,
      endIcon: failure.type == FailureType.noInternet
          ? Icon(Icons.wifi_off_rounded, color: Colors.red, size: 25.textScale)
          : Icon(Icons.error_rounded, color: Colors.red, size: 25.textScale),
    ),
  );
}
