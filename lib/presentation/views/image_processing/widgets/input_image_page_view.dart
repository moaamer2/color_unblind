import 'dart:io';
import 'package:colors_blind/core/extensions/context/showing.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/core/extensions/string/validations.dart';
import 'package:colors_blind/core/services/localization/locale_keys.g.dart';
import 'package:colors_blind/presentation/style/app_colors.dart';
import 'package:colors_blind/presentation/style/app_fonts.dart';
import 'package:colors_blind/presentation/style/app_text_styles.dart';
import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';
import 'package:colors_blind/presentation/views/image_processing/widgets/image_picker.dart';
import 'package:colors_blind/presentation/views/image_processing/widgets/page_view_indicators.dart';
import 'package:colors_blind/presentation/widgets/adaptive_loading_indicator.dart';
import 'package:colors_blind/presentation/widgets/custom_entry.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputImagePageView extends StatefulWidget {
  final Future<void> Function(File image) onImagePicked;
  final Future<void> Function(String description) onDescriptionSend; 

  const InputImagePageView({
    super.key,
    required this.onImagePicked,
    required this.onDescriptionSend,
  });

  @override
  State<InputImagePageView> createState() => _InputImagePageViewState();
}

class _InputImagePageViewState extends State<InputImagePageView> {
  int index = 0;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  File? image;

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return Form(
      key: formKey,
      child: Column(
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  index = value;
                  image = null;
                });
              },
              children: [
                // image picker
                ImagePIckerWidget(
                  onImagePicked: (pickedImage){
                    image = File(pickedImage.path);
                  },
                ),
            
            
                // description feild
                Center(
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 10.staticWidth,),
                    child: CustomEntry(
                      controller: descriptionController,
                      lableText: context.tr(LocaleKeys.imageDescription,),
                      textStyle: TextStyle(
                        color: themeCubit.state.textColor,
                        fontSize: 12.textScale,
                        fontFamily: AppFonts.montserrat,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.staticWidth,
                        vertical: 10.staticHeight,
                      ),
                      focusPrimaryColor: themeCubit.state.primaryColor,
                      maxLines: 10,
                      validator: (value) {
                        if (! value.hasValue){
                          return context.tr(LocaleKeys.imageDescriptionIsRequired);
                        }
                
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
      
          // space between
          SizedBox(height: 10.staticHeight,),
      
          // send button
          Row(
            children: [
              // page view indicators
              PageViewIndicators(
                count: 2,
                currentIndex: index,
                color: themeCubit.state.shadowColor,
                activeColor: themeCubit.state.primaryColor,
              ),
      
              // space between
              const Spacer(),
      
              // button
              GestureDetector(
                onTap: () {
                  if (index == 0){
                    if (image != null){
                      setState(() {
                        isLoading = true;
                      });

                      widget.onImagePicked(image!).then((value) {
                        setState(() {
                          isLoading = false;
                        });
                      });
                    }
                    else{
                      context.showInfoDialoge(
                        message: context.tr(LocaleKeys.pleaseSelectImage),
                        icon: Icon(
                          Icons.warning_rounded,
                          color: AppColors.yellow,
                          size: 80.fromRadius.max(100),
                        ),
                      );
                    }
                  }
                  else{
                    if (formKey.currentState!.validate()){
                      widget.onDescriptionSend(descriptionController.text);
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: themeCubit.state.primaryColor,
                    borderRadius: BorderRadius.circular(2000),
                  ),
                  height: 35.staticHeight,
                  width: 80.staticWidth,
                  child: Center(
                    child: isLoading ? AdaptiveLoadingIndicator(
                      iOSsize: 8,
                      color: AppColors.white,
                      androidSize: 14,
                      androidWidth: 3,
                    ) : Text(
                      context.tr(LocaleKeys.send,),
                      style: AppTextStyles.buttonTextStyle.copyWith(
                        fontSize: 12.textScale,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
