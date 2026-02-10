import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:flutter/material.dart';

class PageViewIndicators extends StatelessWidget {
  final int count;
  final int currentIndex;
  final Color color;
  final Color activeColor;

  const PageViewIndicators({
    super.key,
    required this.count,
    required this.currentIndex,
    this.color = Colors.grey,
    this.activeColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        count,
        (index) => Container(
          width: (index == currentIndex ? 15 : 8).staticWidth,
          height: 8.staticHeight,
          margin: EdgeInsets.symmetric(horizontal: 2.staticWidth,),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3000),
            color: index == currentIndex ? activeColor : color,
          ),
        ),
      ),
    );
  }
}
