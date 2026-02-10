import 'package:colors_blind/core/di/main_di.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/module/enums/processing_type.dart';
import 'package:colors_blind/module/models/color_blind_type.dart';
import 'package:colors_blind/presentation/style/app_colors.dart';
import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';
import 'package:colors_blind/presentation/style/theme/theme_model.dart';
import 'package:colors_blind/presentation/views/video/cubit/live_color_correction_cubit.dart';
import 'package:colors_blind/presentation/views/video/cubit/states.dart';
import 'package:colors_blind/presentation/views/video/widgets/brightness_slider.dart';
import 'package:colors_blind/presentation/views/video/widgets/video_recording_widget.dart';
import 'package:colors_blind/presentation/widgets/custom_tabbar.dart';
import 'package:colors_blind/presentation/widgets/option_switcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveColorCorrectionScreen extends StatelessWidget {
  const LiveColorCorrectionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return BlocBuilder<ThemeCubit, AppTheme>(
      builder: (context, state) => Scaffold(
        backgroundColor: themeCubit.state.backgroundColor,
      
        body: BlocProvider<LiveColorCorrectionCubit>(
          create: (context) => LiveColorCorrectionCubit(getIt(),),
          child: Builder(
            builder: (context) {
              final liveColorCorrectionCubit = context.read<LiveColorCorrectionCubit>();

              return Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 15.staticWidth,),
                child: SafeArea(
                  child: Column(
                    children: [
                      // video preview widget
                      Expanded(
                        child: BlocBuilder<LiveColorCorrectionCubit,LiveColorCorrectionState>(
                          buildWhen: (previous, current) => current is LiveColorCorrectionSuccessState,
                          builder: (context, state) => VideoRecordingWidget(
                            colorFilter: state is LiveColorCorrectionSuccessState
                              ? state.colorFilter : null,
                          ),
                        ),
                      ),
                  
                      // divider
                      Divider(
                        color: themeCubit.state.borderColor,
                        thickness: 1.staticRadius,
                        indent: 50.staticWidth,
                        endIndent: 50.staticWidth,
                        height: 20.staticHeight,
                      ),
                  
                      // type selector
                      Row(
                        children: [
                          Expanded(
                            child: CustomTabbar<ColorBlindType>.colorsBlind(
                              context, items: ColorBlindType.values,
                              behavior: TabbarBehavior.singleSelectNonEmpty,
                              tabWidth: 100.staticWidth,
                              getLable: (value) => context.tr(value.name),
                              onTap: (type,index){
                                liveColorCorrectionCubit.type = type;
                              }
                            ),
                          ),

                          
                          // space between
                          SizedBox(width: 10.staticWidth,),

                          // brightness value display
                          BlocBuilder<LiveColorCorrectionCubit,LiveColorCorrectionState>(
                            builder: (context, state) => Container(
                              decoration: BoxDecoration(
                                color: themeCubit.state.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(11.staticRadius,),
                              alignment: Alignment.center,
                              child: Text(
                                '${liveColorCorrectionCubit.brightness.toInt()}%',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 10.textScale,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ),
                        ],
                      ),
                  
                      // space between
                      SizedBox(height: 5.staticHeight,),
                  
                      // brightness slider
                      Row(
                        children: [
                          Expanded(
                            child: BrightnessSlider(
                              initialBrightness: liveColorCorrectionCubit.brightness,
                              onChanged: (value) {
                                liveColorCorrectionCubit.brightness = value;
                              },
                            ),
                          ),

                          // space between
                          SizedBox(width: 10.staticWidth,),

                          // processing type selector
                          OptionSwitcher<ProcessingType>.colorsBlind(
                            context,
                            items: ProcessingType.values,
                            width: 120.staticWidth,
                            height: 25.fromHeight.max(40),
                            getLable: (item) => context.tr(item.name),
                            onSelect: (type,index) {
                              liveColorCorrectionCubit.processingType = type;
                            },
                          ),
                        ],
                      ),
                  
                      // bottom space
                      SizedBox(height: 5.staticHeight,),
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
