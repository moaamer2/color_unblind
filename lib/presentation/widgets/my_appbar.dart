import 'package:flutter/material.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';

class MyAppbar extends StatelessWidget implements PreferredSize{
  final String title;
  final Widget? suffixIcon;
  final Color backgroundColor;
  final TextStyle? textStyle;
  final Widget? content;

  const MyAppbar({
    super.key,
    required this.title,
    this.suffixIcon,
    this.backgroundColor = const Color.fromARGB(0, 255, 255, 255),
    this.textStyle,
    this.content,
  });
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      toolbarHeight: ((textStyle?.fontSize ?? 0) > 30 ? 57 : 50).fromHeight,
      backgroundColor: backgroundColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8,right: 8,top: 10.fromHeight,),
            child: Text(title,style: textStyle,),
          ),

          Expanded(
            child: SizedBox(
              height: preferredSize.height,
              child: content,
            ),
          ),

          SizedBox(width: 5.fromWidth.max(10),),

          suffixIcon ?? const SizedBox.shrink(),
        ],
      ),
    );
  }

  @override
  Widget get child => const SizedBox();

  @override
  Size get preferredSize => Size(double.infinity,((textStyle?.fontSize ?? 0) > 30 ? 57 : 50).fromHeight);
}