import 'package:colors_blind/core/extensions/context/navigation.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/core/services/localization/locale_keys.g.dart';
import 'package:colors_blind/presentation/style/app_colors.dart';
import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';
import 'package:colors_blind/presentation/views/colors_blind_test/blind_test_sscreen.dart';
import 'package:colors_blind/presentation/views/image_processing/image_processing_screen.dart';
import 'package:colors_blind/presentation/views/start/widgets/setting_container_widget.dart';
import 'package:colors_blind/presentation/views/video/live_color_correction_screen.dart';
import 'package:colors_blind/presentation/widgets/my_buttom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartButtomSheet extends StatelessWidget {
  const StartButtomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return MybuttomSheet(
      height: 300.fromHeight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.staticWidth,),
        child: Column(
          spacing: 15.staticHeight,
          children: [
            GestureDetector(
              onTap: () {
                context.pushReplacement(
                  BlindTestSscreen(),
                );
              },
              child: SettingContainerWidget(
                title: context.tr(LocaleKeys.colorsBlindTest),
                icon: Icons.color_lens_rounded,
                primaryColor: themeCubit.state.primaryColor,
                backgroundColor: themeCubit.state.secondaryColor,
                titleStyle: TextStyle(
                  color: AppColors.veryLightBlack,
                  fontSize: 14.textScale,
                ),
              ),
            ),
        
            GestureDetector(
              onTap: () {
                context.pushReplacement(
                  LiveColorCorrectionScreen(),
                );
              },
              child: SettingContainerWidget(
                title: context.tr(LocaleKeys.liveColorCorrection),
                icon: Icons.video_camera_back_rounded,
                primaryColor: themeCubit.state.primaryColor,
                backgroundColor: themeCubit.state.secondaryColor,
                titleStyle: TextStyle(
                  color: AppColors.veryLightBlack,
                  fontSize: 14.textScale,
                ),
              ),
            ), 
        
            GestureDetector(
              onTap: () {
                context.pushReplacement(
                  ImageProcessingScreen(),
                );
              },
              child: SettingContainerWidget(
                title: context.tr(LocaleKeys.imageProcessing,),
                icon: Icons.image_rounded,
                primaryColor: themeCubit.state.primaryColor,
                backgroundColor: themeCubit.state.secondaryColor,
                titleStyle: TextStyle(
                  color: AppColors.veryLightBlack,
                  fontSize: 14.textScale,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
