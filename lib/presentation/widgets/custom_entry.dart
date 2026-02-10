import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/presentation/style/app_colors.dart';
import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';

class CustomEntry extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String? value) validator;
  final String? lableText;
  final void Function()? onChange;
  final TextInputType? inputType;
  final bool active;
  final int maxLines;
  final Color backgroundColor;
  final Color focusPrimaryColor;
  final Color boarderColor;
  final double raduis;
  final EdgeInsets? contentPadding;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? textStyle;

  const CustomEntry({
    super.key,
    required this.controller,
    required this.validator,
    this.lableText,
    this.inputType,
    this.active = true,
    this.maxLines = 1,
    this.onChange,
    this.backgroundColor = const Color.fromARGB(0, 255, 255, 255),
    this.focusPrimaryColor = Colors.blue,
    this.raduis = 10,
    this.contentPadding,
    this.suffixIcon,
    this.prefixIcon,
    this.textStyle,
    this.boarderColor = Colors.grey,
  });

  factory CustomEntry.colorsBlind(
    BuildContext context, {
      required TextEditingController controller,
      required String? Function(String? value) validator,
      required String? lableText,
      int maxLines = 1,
    }
  ){
    final themeCubit = context.read<ThemeCubit>();

    return CustomEntry(
      controller: controller,
      validator: validator,
      lableText: lableText,
      maxLines: maxLines,
      contentPadding: EdgeInsets.symmetric(horizontal: 15.fromWidth.max(20),vertical: 10.staticHeight),
      boarderColor: AppColors.grey,
      focusPrimaryColor: themeCubit.state.primaryColor,
      textStyle: TextStyle(
        color: themeCubit.state.textColor,
        fontSize: 12.textScale,
      ),
    );
  }

  @override
  State<CustomEntry> createState() => _CustomEntryState();
}

class _CustomEntryState extends State<CustomEntry> {
  bool enabled = false;
  bool error = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      enabled: widget.active,
      controller: widget.controller,
      keyboardType: widget.inputType,
      cursorColor: widget.focusPrimaryColor,
      textInputAction: widget.maxLines == 1 ? TextInputAction.next : TextInputAction.newline,
      validator: (value){
        if (widget.validator(value) == null){
          error = false;
        }
        else{
          error = true;
        }
        setState((){});
        return widget.validator(value);
      },
      onChanged: (value){
        if(widget.onChange != null) widget.onChange!();
      },
      onTapOutside: (event){
        FocusManager.instance.primaryFocus!.unfocus();
        setState(() {
          enabled = false;
        });
      },
      onFieldSubmitted: (value) => setState(() => enabled = false),
      onTap: () => setState(() => enabled = true),
      style: (enabled ? widget.textStyle : widget.textStyle?.copyWith(
        color: Colors.grey,
      )) ?? TextStyle(
        fontSize: 13.5,
        color: enabled ? widget.textStyle?.color : Colors.grey,
      ),
      decoration: InputDecoration(
        labelText: widget.lableText,
        contentPadding: widget.contentPadding ?? EdgeInsets.symmetric(horizontal: 15.fromWidth.max(20),vertical: 12.fromHeight.max(20)),
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.raduis),
          borderSide: BorderSide(
            color: widget.boarderColor,
            width: 1.fromRadius.max(2),
          ),
        ),
        filled: true,
        fillColor: widget.backgroundColor,
        hintText: widget.lableText,
        hintStyle: widget.textStyle?.copyWith(
          color: Color(0xff757575),
        ) ?? TextStyle(
          color: Color(0xff757575),
          fontSize: 13.5,
          fontFamily: widget.textStyle?.fontFamily,
        ),
        labelStyle: widget.textStyle?.copyWith(
          color: enabled ? (error ? const Color.fromARGB(255, 255, 17, 0) : widget.focusPrimaryColor) : Colors.grey,
        ) ?? TextStyle(
          color: enabled ? (error ? const Color.fromARGB(255, 255, 17, 0) : widget.focusPrimaryColor) : Colors.grey,
          fontSize: 13,
          fontFamily: widget.textStyle?.fontFamily,
        ),
        errorStyle: TextStyle(
          color: const Color.fromARGB(255, 255, 17, 0),
          fontSize: 11.textScale,
          fontFamily: widget.textStyle?.fontFamily,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.raduis.fromRadius.max(widget.raduis * 1.2)),
          borderSide: BorderSide(
            color: widget.boarderColor,
            width: 1.5.fromRadius.max(2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.raduis.fromRadius.max(widget.raduis * 1.2)),
          borderSide: BorderSide(
            color: widget.focusPrimaryColor,
            width: 1.5.fromRadius.max(2),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.raduis.fromRadius.max(widget.raduis * 1.2)),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 255, 17, 0),
            width: 1.5.fromRadius.max(2),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.raduis.fromRadius.max(widget.raduis * 1.2)),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 255, 17, 0),
            width: 1.5.fromRadius.max(2),
          ),
        ),
      ),
    );
  }
}