import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/presentation/style/app_colors.dart';
import 'package:colors_blind/presentation/style/app_fonts.dart';
import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';

class TypeSelector<T> extends StatefulWidget {
  final void Function(T item, int index) onChange;
  final List<T> types;
  final List<TypeLable> lables;
  final SelectorStyle? style;

  const TypeSelector({
    super.key,
    required this.types,
    required this.onChange,
    this.lables = const [],
    this.style,
  });

  factory TypeSelector.colorsBlind(
    BuildContext context, {
      required void Function(T item, int index) onChange,
      required List<T> types,
      required List<TypeLable> lables,
    }
  ){
    final themeCubit = context.read<ThemeCubit>();

    return TypeSelector<T>(
      onChange: onChange,
      types: types,
      lables: lables,
      style: SelectorStyle(
        primaryColor: themeCubit.state.primaryColor,
        nonActivePrimaryColor: AppColors.darkGrey,
        activeColor: themeCubit.state.secondaryColor,
        nonActiveColor: AppColors.grey,
        selectorRadius: 20.fromRadius.max(25),
        textStyle: TextStyle(
          color: AppColors.veryLightBlack,
          fontSize: 18.textScale,
          fontFamily: AppFonts.montserrat,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  State<TypeSelector<T>> createState() => _TypeSelectorState<T>();
}

class _TypeSelectorState<T> extends State<TypeSelector<T>> {
  late SelectorStyle _style;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _style = widget.style ?? SelectorStyle();
  }

  String _getLableString(int index){
    if (index >= widget.lables.length){
      return widget.types[index].toString();
    }
    else{
      return widget.lables[index].title;
    }
  }

  IconData _getLableIcon(int index){
    if (index >= widget.lables.length){
      return Icons.type_specimen_rounded;
    }
    else{
      return widget.lables[index].icon;
    }
  }

  double getTextSize(int textLength,){
    return (textLength * 10.0).clamp(
      40.fromRadius.max(40),
      65.fromRadius.max(65),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    _style = widget.style ?? SelectorStyle();
    return Row(
      children: List<Widget>.generate(
        widget.types.length,
        (index){
          return Expanded(
            child: AspectRatio(
              aspectRatio: 1.2,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _index = index;
                    widget.onChange(widget.types[index],index);
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.fromWidth.max(6)),
                  padding: EdgeInsets.all(10.fromRadius.max(10)),
                  decoration: BoxDecoration(
                    color: _index == index ? _style.activeColor : _style.nonActiveColor,
                    borderRadius: BorderRadius.circular(_style.selectorRadius),
                    border: Border.all(
                      color: _index == index ? _style.primaryColor : const Color.fromARGB(0, 255, 255, 255),
                      width: 2.fromRadius.max(2),
                    ),
                  ),


                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // left space
                      const Spacer(flex: 20,),

                      Expanded(
                        flex: 60,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.fromWidth.max(5),
                            vertical: 5.fromHeight.max(5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // icon
                              Expanded(
                                flex: 70,
                                child: Center(
                                  child: SizedBox(
                                    width: 75.fromRadius.max(75),
                                    height: 75.fromRadius.max(75),
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Icon(
                                        _getLableIcon(index),
                                        color: index == _index ? _style.primaryColor : _style.nonActivePrimaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                                                      
                              // space between
                              SizedBox(height: 5.fromHeight.max(7),),
                                                      
                              // lable
                              Expanded(
                                flex: 30,
                                child: Center(
                                  child: SizedBox(
                                    width: getTextSize(_getLableString(index).length),
                                    height: getTextSize(_getLableString(index).length),
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        context.tr(_getLableString(index)),
                                        style: _style.textStyle,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // right space
                      Expanded(
                        flex: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child: index == _index ? Icon(
                                Icons.check_circle_rounded,
                                color: _style.primaryColor,
                              ) : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}



class TypeLable {
  final String title;
  final IconData icon;

  TypeLable({
    required this.title,
    required this.icon,
  });
}


class SelectorStyle {
  final Color primaryColor;
  final Color activeColor;
  final Color nonActiveColor;
  final Color nonActivePrimaryColor;
  final double selectorRadius;
  final TextStyle? textStyle;

  SelectorStyle({
    this.primaryColor = Colors.blue,
    this.activeColor = Colors.white,
    this.nonActiveColor = const Color.fromARGB(255, 209, 209, 209),
    this.nonActivePrimaryColor = Colors.grey,
    this.selectorRadius = 15,
    this.textStyle,
  });
}
