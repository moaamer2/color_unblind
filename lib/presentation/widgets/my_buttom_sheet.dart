import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:colors_blind/core/extensions/context/media_query.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';

class MybuttomSheet extends StatelessWidget {
  final Widget child;
  final double? height;
  final Color? color;
  final Function()? onClose;
  const MybuttomSheet({
    super.key,
    required this.child,
    this.height = 100,
    this.color,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    return Container(
      height: height,
      width: context.screenWidth,
      decoration: BoxDecoration(
        color: color ?? themeCubit.state.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.fromRadius),
          topRight: Radius.circular(12.fromRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: themeCubit.state.shadowColor,
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: Offset(-1,-1,),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.fromWidth,vertical: 10.fromHeight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // down indicator
          Center(
            child: GestureDetector(
              onVerticalDragEnd: (details) {
                if (onClose != null) onClose!();
              },
              child: Container(
                width: 150.fromWidth.max(150),
                height: 5.fromHeight,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 211, 211, 211),
                  borderRadius: BorderRadius.circular(15.fromRadius),
                ),
              ),
            ),
          ),

          // space between
          SizedBox(height: 30.fromHeight,),

          // child
          Expanded(child: child),
        ],
      ),
    );
  }
}
