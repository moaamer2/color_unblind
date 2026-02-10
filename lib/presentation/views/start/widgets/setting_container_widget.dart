import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:flutter/material.dart';

class SettingContainerWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color primaryColor;
  final String title;
  final IconData icon;
  final Widget? trailing;
  final TextStyle? titleStyle;

  const SettingContainerWidget({
    super.key,
    this.backgroundColor = Colors.white,
    this.primaryColor = Colors.blue,
    required this.title,
    required this.icon,
    this.trailing,
    this.titleStyle
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18.fromRadius.max(25))
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.fromWidth.max(10),vertical: 10.fromHeight.max(15)),
      child: Row(
        children: [
          // icon
          Icon(
            icon,
            color: primaryColor,
            size: 25.textScale,
          ),
            
          // space between
          SizedBox(width: 10.fromWidth.max(10),),
            
          // title
          Text(
            title,
            style: titleStyle,
          ),
            
          // space between
          const Spacer(),
            
          // icon
          trailing ?? Icon(
            Icons.arrow_forward_ios_rounded,
            color: primaryColor,
            size: 18.textScale,
          ),
        ],
      ),
    );
  }
}



// language
// theme
// dark mode