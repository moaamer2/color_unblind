import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/presentation/style/app_colors.dart';
import 'package:colors_blind/presentation/style/app_fonts.dart';
// import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';

SnackBar getSnackBar({
  required String message,
  Widget? endIcon,
  Color? iconColor,
  Color? backgroundColor,
}) {
  return SnackBar(
    elevation: 0,
    backgroundColor: const Color.fromARGB(0, 255, 255, 255),
    content: CustomSnackBar(
      message: message,
      iconColor: iconColor,
      backgroundColor: backgroundColor ?? Colors.white,
      end: endIcon,
      textStyle: TextStyle(
        fontFamily: AppFonts.impact,
        fontSize: 15.textScale,
        color: AppColors.darkGrey,
      ),
    ),
  );
}

class CustomSnackBar extends StatelessWidget {
  final String message;
  final Widget? end;
  final Color backgroundColor;
  final TextStyle? textStyle;
  final Color? iconColor;
  const CustomSnackBar({
    super.key,
    required this.message,
    this.end,
    this.backgroundColor = const Color.fromARGB(0, 255, 255, 255),
    this.textStyle,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    // final themeCubit = context.read<ThemeCubit>();

    return Center(
      child: Stack(
        children: [
          Container(
            width: 600.staticWidth,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10.fromHeight,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10.fromRadius.max(20)),
              border: Border.all(
                color: AppColors.darkGrey,
                width: 1.fromRadius.max(2),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 215, 215, 215),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(-1, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(child: Text(message, style: textStyle)),
                SizedBox(width: 10.fromWidth.max(15)),
                end ?? const SizedBox(),
              ],
            ),
          ),
      
          // Positioned(
          //   top: 0,
          //   child: Padding(
          //     padding: EdgeInsets.only(left: 10.staticWidth),
          //     child: Icon(
          //       Icons.notifications_rounded,
          //       color: iconColor ?? themeCubit.state.primaryColor,
          //       size: 35.textScale,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
