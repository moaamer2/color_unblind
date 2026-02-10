import 'package:flutter/material.dart';
import 'package:colors_blind/core/extensions/context/media_query.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';

class BigButton extends StatelessWidget {
  final Widget child;
  final bool isActive;
  final Color backgroundColor;
  final Color nonActiveColor;
  final void Function() command;
  final double height;
  final double raduis;
  final double? width;
  final BoxBorder? border;
  const BigButton({
    super.key,
    required this.child,
    required this.command,
    this.isActive = true,
    this.backgroundColor = Colors.blue,
    this.nonActiveColor = const Color.fromARGB(154, 64, 195, 255),
    this.height = 45,
    this.raduis = 0,
    this.width,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(isActive){
          command();
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: width ?? context.screenWidth,
        padding: EdgeInsets.symmetric(horizontal: 20.fromWidth, vertical: 15.fromHeight.max(15)),
        decoration: BoxDecoration(
          color: isActive ? backgroundColor : nonActiveColor,
          borderRadius: BorderRadius.circular(raduis),
          border: border,
        ),
        child: child,
      ),
    );
  }
}
