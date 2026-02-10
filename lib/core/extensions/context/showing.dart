import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/core/services/localization/locale_keys.g.dart';
import 'package:colors_blind/presentation/style/app_colors.dart';
import 'package:colors_blind/presentation/style/app_fonts.dart';
import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';

extension Showing on BuildContext {
  void showSnackBar({required SnackBar snackBar}) {
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }

  void showLoadingDialog() {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  void showConfirmDialog({required String message,required void Function() onConfirm,void Function()? onCancel}){
    showDialog(
      context: this,
      builder: (context){
        final themeCubit = context.read<ThemeCubit>();
        return GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Scaffold(
            backgroundColor: const Color.fromARGB(0, 255, 255, 255),
            body: Center(
              child: Container(
                width: 400,
                height: 250.fromHeight.max(400),
                margin: EdgeInsets.symmetric(horizontal: 20.fromWidth,),
                decoration: BoxDecoration(
                  color: themeCubit.state.backgroundColor,
                  borderRadius: BorderRadius.circular(20.fromRadius),
                  boxShadow: [
                    BoxShadow(
                      color: themeCubit.state.secondaryColor,
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(-1,1,),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 20.fromHeight,),
                child: Column(
                  children: [
                    // alert icon
                    Icon(
                      Icons.warning_rounded,
                      color: Colors.amber,
                      size: 80.fromRadius.max(120),
                    ),
              
                    // space between
                    SizedBox(height: 10.fromHeight,),
              
                    // alert message
                    Text(
                      '${context.tr(LocaleKeys.areYouSureYouWantTo)}\n$message',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: themeCubit.state.textColor,
                        fontSize: 16.textScale,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              
                    // space between
                    const Spacer(),
              
                    // confirm buttons
                    Row(
                      spacing: 20.fromWidth.max(20),
                      children: [
                        // right space
                        SizedBox(width: 20.fromWidth.max(20),),
              
                        // cancel button
                        Expanded(
                          child: GestureDetector(
                            onTap: onCancel ?? () => Navigator.pop(context),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10.fromHeight,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.fromRadius.max(20)),
                                ),
                                color: AppColors.grey,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                context.tr(LocaleKeys.cancel),
                                style: TextStyle(
                                  color: themeCubit.state.textColor,
                                  fontSize: 14.textScale,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
              
                        // confirm button
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              onConfirm();
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10.fromHeight,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.fromRadius.max(20)),
                                ),
                                color: themeCubit.state.primaryColor,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                context.tr(LocaleKeys.confirm),
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12.textScale,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
              
                        // left space
                        SizedBox(width: 20.fromWidth.max(20),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  void showInfoDialoge({required String message,Widget? icon}){
    showDialog(
      context: this,
      builder: (context){
        final themeCubit = context.read<ThemeCubit>();
        return Center(
          child: IntrinsicHeight(
            child: Container(
              width: 400.fromWidth.max(400),
              margin: EdgeInsets.symmetric(horizontal: 20.fromWidth,),
              decoration: BoxDecoration(
                color: themeCubit.state.backgroundColor,
                borderRadius: BorderRadius.circular(20.fromRadius),
                boxShadow: [
                  BoxShadow(
                    color: themeCubit.state.secondaryColor,
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(-1,1,),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 20.fromHeight,),
              child: Column(
                children: [
                  // alert icon
                  icon ?? Icon(
                    Icons.info_rounded,
                    color: themeCubit.state.primaryColor,
                    size: 80.fromRadius.max(120),
                  ),
            
                  // space between
                  SizedBox(height: 10.fromHeight,),
            
                  // alert message
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: themeCubit.state.textColor,
                      fontSize: 15.textScale,
                    )
                  ),
            
                  // space between
                  SizedBox(height: 30.fromHeight,),
            
                  // confirm buttons
                  Row(
                    spacing: 20.fromWidth.max(20),
                    children: [
                      // right space
                      SizedBox(width: 20.fromWidth.max(20),),
            
                      // confirm button
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.fromHeight,),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.fromRadius.max(20)),
                              ),
                              color: themeCubit.state.primaryColor,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              context.tr(LocaleKeys.ok,),
                              style: TextStyle(
                                fontSize: 12.textScale,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.montserrat,
                              ),
                            ),
                          ),
                        ),
                      ),
            
                      // left space
                      SizedBox(width: 20.fromWidth.max(20),),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
