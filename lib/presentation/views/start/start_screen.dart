import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/core/helper/app_constants.dart';
import 'package:colors_blind/core/services/localization/locale_keys.g.dart';
import 'package:colors_blind/core/services/url_lancher/url_lancher_service.dart';
import 'package:colors_blind/presentation/style/app_assets.dart';
import 'package:colors_blind/presentation/style/app_colors.dart';
import 'package:colors_blind/presentation/style/app_fonts.dart';
import 'package:colors_blind/presentation/style/app_text_styles.dart';
import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';
import 'package:colors_blind/presentation/views/start/widgets/start_buttom_sheet.dart';
import 'package:colors_blind/presentation/widgets/big_button.dart';
import 'package:colors_blind/presentation/widgets/dark_mode_switcher_widget.dart';
import 'package:colors_blind/presentation/widgets/language_swithcer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return Scaffold(
      backgroundColor: themeCubit.state.backgroundColor,
      
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // top space 
              SizedBox(height: 5.staticHeight,),

              // dark mode switcher
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 10.staticWidth,),
                child: DarkModeSwitcherWidget(),
              ),
        
              // space between
              const Spacer(),
        
              // app logo
              Image.asset(
                width: 150.fromRadius.max(200),
                height: 150.fromRadius.max(200),
                AppAssets.appLogo,
              ),
          
              // space between
              SizedBox(height: 50.staticHeight,),
          
              // app name
              Text(
                context.tr(LocaleKeys.colorsBlindHelper),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: themeCubit.state.textColor,
                  fontSize: 25.textScale,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.impact,
                ),
              ),
          
          
              // space between
              SizedBox(height: 10.staticHeight,),
          
          
              // app description
              Text(
                context.tr(LocaleKeys.correctYourColorsInsight),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: themeCubit.state.primaryColor,
                  fontSize: 16.textScale,
                  fontFamily: AppFonts.montserrat,
                  fontWeight: FontWeight.bold,
                ),
              ),
          
          
              // app description
              Text(
                context.tr(LocaleKeys.exploreWorldWithItsRealColors),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.moreDarkGrey,
                  fontSize: 16.textScale,
                  fontFamily: AppFonts.montserrat,
                ),
              ),
          
          
              // space between
              SizedBox(height: 100.staticHeight,),
          
          
              // start button
              BigButton(
                width: 300.staticWidth,
                command: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => StartButtomSheet(),
                  );
                },
              
                backgroundColor: themeCubit.state.primaryColor,
                raduis: 3000.fromRadius,
              
                child: Text(
                  context.tr(LocaleKeys.start),
                  style: AppTextStyles.buttonTextStyle.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),

              // space between
              SizedBox(height: 20.staticHeight,),

              // web version text
              Row(
                spacing: 5.staticWidth,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // web icon
                  Icon(
                    Icons.language_rounded,
                    color: themeCubit.state.primaryColor,
                    size: 18.textScale,
                  ),

                  // click text
                  Text(
                    context.tr(LocaleKeys.click),
                    style: TextStyle(
                      color: themeCubit.state.textColor,
                      fontSize: 14.textScale,
                      fontFamily: AppFonts.montserrat,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      UrlLanchService.openUrl(AppConstants.webVersionUrl);
                    },
                    child: Text(
                      context.tr(LocaleKeys.here),
                      style: TextStyle(
                        color: themeCubit.state.primaryColor,
                        fontSize: 14.textScale,
                        fontFamily: AppFonts.montserrat,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: themeCubit.state.primaryColor,
                      ),
                    ),
                  ),

                  // for the web version text
                  Text(
                    ' ${context.tr(LocaleKeys.forTheWebversion)}',
                    style: TextStyle(
                      color: themeCubit.state.textColor,
                      fontSize: 14.textScale,
                      fontFamily: AppFonts.montserrat,
                    ),
                  ),
                ],
              ),
        
      
              // space between
              const Spacer(),
        
        
              // language swithcer
              LanguageSwithcer(),
        
        
              // bottom space
              SizedBox(height: 40.staticHeight,),
            ],
          ),
        ),
      ),
    );
  }
}
