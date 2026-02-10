import 'package:colors_blind/core/di/main_di.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/core/helper/show_error_snake_bar.dart';
import 'package:colors_blind/core/services/localization/locale_keys.g.dart';
import 'package:colors_blind/module/models/color_blind_type.dart';
import 'package:colors_blind/presentation/style/app_text_styles.dart';
import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';
import 'package:colors_blind/presentation/style/theme/theme_model.dart';
import 'package:colors_blind/presentation/views/image_processing/cubit/process_image_cubit.dart';
import 'package:colors_blind/presentation/views/image_processing/cubit/states.dart';
import 'package:colors_blind/presentation/views/image_processing/widgets/input_image_page_view.dart';
import 'package:colors_blind/presentation/views/image_processing/widgets/output_image_widget.dart';
import 'package:colors_blind/presentation/widgets/custom_tabbar.dart';
import 'package:colors_blind/presentation/widgets/dark_mode_and_language_widget.dart';
import 'package:colors_blind/presentation/widgets/my_sub_appbar.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageProcessingScreen extends StatelessWidget {
  const ImageProcessingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return BlocBuilder<ThemeCubit, AppTheme>(
      builder: (context, state) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: themeCubit.state.backgroundColor,
      
        appBar: MySubAppbar(
          title: context.tr(LocaleKeys.imageProcessing,),
          titleStyle: AppTextStyles.appBarTitle.copyWith(
            color: themeCubit.state.textColor,
            fontSize: 25.textScale,
          ),
        ),
      
        body: BlocProvider<ProcessImageCubit>(
          create: (context) => ProcessImageCubit(getIt(),),
          child: Builder(
            builder: (context) {
              final processImageCubit = context.read<ProcessImageCubit>();

              return Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 15.staticWidth,vertical: 10.staticHeight,),
                child: Column(
                  children: [
                    // dark mode and language
                    DarkModeAndLanguageWidget(),
              
                    // color blind selector 
                    CustomTabbar<ColorBlindType>.colorsBlind(
                      context,
                      behavior: TabbarBehavior.singleSelectNonEmpty,
                      items: ColorBlindType.values,
                      tabWidth: 35.fromWidth + 75.staticWidth,
                      height: 35.staticHeight + 5.staticHeight,
                      getLable: (value) => value.name,
                      onTap: (type,index){
                        processImageCubit.colorBlindType = type;
                      }
                    ),
              
                    // space between
                    SizedBox(height: 10.staticHeight,),
                    
                    // input image picker widget
                    Expanded(
                      flex: 52,
                      child: InputImagePageView(
                        onImagePicked: processImageCubit.processImage,
                        onDescriptionSend: processImageCubit.generateImage,
                      ),
                    ),
                
                
                    // space between
                    SizedBox(height: 10.staticHeight,),
                
                    // output image
                    Expanded(
                      flex: 48,
                      child: BlocConsumer<ProcessImageCubit, ProcessImageState>(
                        listener: (context, state) {
                          if(state is ProcessImageErrorState){
                            showErrorSnakeBar(context, state.failure);
                          }
                        },
                        builder: (context, state) {
                          return OutputImageWidget(
                            url: state is ProcessImageSuccessState ? state.image : null,
                            isloading: state is ProcessImageLoadingState,
                            hasError: state is ProcessImageErrorState,
                          );
                        },                        
                      ),
                    ),
                    
                    
                    // bottom space 
                    SizedBox(height: 50.staticHeight,),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
