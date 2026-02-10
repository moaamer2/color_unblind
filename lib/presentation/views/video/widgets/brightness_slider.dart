import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/presentation/style/app_fonts.dart';
import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrightnessSlider extends StatefulWidget {
  final void Function(double value)? onChanged;
  final double initialBrightness;

  const BrightnessSlider({
    super.key,
    this.onChanged,
    this.initialBrightness = 50,
  });

  @override
  State<BrightnessSlider> createState() => _BrightnessSliderState();
}

class _BrightnessSliderState extends State<BrightnessSlider> {
  double brightness = 50;

  @override
  void initState() {
    super.initState();
    brightness = widget.initialBrightness;
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return Column(
      children: [
        Slider(
          padding: EdgeInsets.zero,
          value: brightness,
          min: 0,
          max: 100,
          secondaryActiveColor: themeCubit.state.secondaryColor,
          activeColor: themeCubit.state.primaryColor,
          inactiveColor: themeCubit.state.shadowColor,
          label: brightness.round().toString(),
          onChanged: (value) {
            setState(() {
              brightness = value;
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            });
          },
        ),

        Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: 5.staticWidth,
          ),
          child: Row(
            children: [
              Text(
                '0',
                style: TextStyle(
                  color: themeCubit.state.textColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.impact,
                  fontSize: 12.textScale,
                ),
              ),
          
              const Spacer(),
          
              Text(
                '100',
                style: TextStyle(
                  color: themeCubit.state.textColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.impact,
                  fontSize: 12.textScale,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
