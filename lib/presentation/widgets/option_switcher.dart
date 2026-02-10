import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/presentation/style/app_fonts.dart';
import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';

class OptionSwitcher<T> extends StatefulWidget {
  final Color? backgroundColor;
  final Color? primaryColor;
  final Color? shadowColor;
  final List<T> items;
  final String Function(T item)? getLable;
  final void Function(T item,int index) onSelect;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final T? initValue;

  OptionSwitcher({
    required this.items,
    required this.onSelect,
    this.getLable,
    this.primaryColor,
    this.backgroundColor,
    this.shadowColor,
    this.textStyle,
    this.width,
    this.height,
    this.initValue,
    super.key,
  }){
    if (items.length != 2){
      throw Exception('Items must be 2');
    }
  }

  factory OptionSwitcher.colorsBlind(
    BuildContext context,
    {
      required List<T> items,
      required void Function(T item,int index) onSelect,
      final String Function(T item)? getLable,
      final double? width,
      final double? height,
      final T? initValue
    }
  ){
    final themeCubit = context.read<ThemeCubit>();

    return OptionSwitcher<T>(
      items: items,
      onSelect: onSelect,
      getLable: getLable,
      width: width,
      height: height,
      initValue: initValue,
      backgroundColor: themeCubit.state.backgroundColor,
      primaryColor: themeCubit.state.primaryColor,
      shadowColor: themeCubit.state.shadowColor,
      textStyle: TextStyle(
        color: themeCubit.state.textColor,
        fontSize: 14.textScale,
        fontFamily: AppFonts.montserrat,
      ),
    );
  }

  @override
  State<OptionSwitcher<T>> createState() => _OptionSwitcherState<T>();
}

class _OptionSwitcherState<T> extends State<OptionSwitcher<T>> {
  int index = 0;
  bool get _isrtl => Directionality.of(context) == TextDirection.rtl;

  void initIndex(){
    if (widget.initValue != null){
      index = widget.items.indexOf(widget.initValue as T);
    }
  }

  @override
  void initState() {
    initIndex();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initIndex();

    return Container(
      width: widget.width ?? 100,
      height: widget.height ?? 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35.fromRadius,),
        color: widget.backgroundColor ?? Colors.white,
        boxShadow: [
          BoxShadow(
            color: widget.shadowColor ?? Colors.grey,
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 0.5,),
          )
        ]
      ),

      child: Stack(
        alignment: Alignment.center,
        children: [
          // animated slider 
          AnimatedAlign(
            alignment: index == (0) ? Alignment.centerLeft : Alignment.centerRight,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: Container(
              width: (widget.width ?? 100) / 2,
              height: widget.height ?? 30,
              decoration: BoxDecoration(
                color: widget.primaryColor ?? Colors.blue,
                borderRadius: BorderRadius.circular(35),
              ),
            ),
          ),

          // options
          Transform.flip(
            flipX: _isrtl,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        index = 0;
                        widget.onSelect(widget.items[0],index);
                      });
                    },
                    child: Container(
                      height: widget.height ?? 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35.fromRadius,),
                        color: const Color.fromARGB(0, 255, 255, 255),
                      ),
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Transform.flip(
                          flipX: _isrtl,
                          child: Text(
                            widget.getLable != null ? widget.getLable!(widget.items[0]) : widget.items[0].toString(),
                            style: index == 0 ? widget.textStyle?.copyWith(color: Colors.white) 
                            ?? const TextStyle(color: Colors.white) : widget.textStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        index = 1;
                        widget.onSelect(widget.items[1],index);
                      });
                    },
                    child: Container(
                      height: widget.height ?? 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35.fromRadius,),
                        color: const Color.fromARGB(0, 255, 255, 255),
                      ),
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Transform.flip(
                          flipX: _isrtl,
                          child: Text(
                            widget.getLable != null ? widget.getLable!(widget.items[1]) : widget.items[1].toString(),
                            style: index == 1 ? widget.textStyle?.copyWith(color: Colors.white) 
                            ?? const TextStyle(color: Colors.white) : widget.textStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
