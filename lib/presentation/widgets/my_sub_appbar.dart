import 'dart:io';
import 'package:flutter/material.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';

class MySubAppbar extends StatelessWidget implements PreferredSize{
  final String title;
  final Widget? suffixIcon;
  final void Function()? popCommand;
  final Color backgroundColor;
  final TextStyle? titleStyle;
  const MySubAppbar({
    super.key,
    required this.title,
    this.suffixIcon,
    this.popCommand,
    this.backgroundColor = const Color.fromARGB(0, 255, 255, 255),
    this.titleStyle,    
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8,right: 8,top: 10.fromHeight,),
      child: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: ((titleStyle?.fontSize ?? 0) > 30 ? 57 : 50).fromHeight,
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: (){
            if (popCommand != null) {
              popCommand!();
            }
            else{
              Navigator.pop(context);
            }
          },
          child: Icon(
            Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            color: Colors.grey,
            size: (Platform.isIOS ? 25 : 30).staticRadius,
          ),
        ),
        title: Text(title,style: titleStyle,),
        actions: [suffixIcon ?? const SizedBox()],
      ),
    );
  }

  @override
  Widget get child => const SizedBox();

  @override
  Size get preferredSize => Size(double.infinity,((titleStyle?.fontSize ?? 0) > 30 ? 57 : 50).fromHeight);
}

