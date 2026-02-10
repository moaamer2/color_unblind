import 'dart:io';
import 'package:flutter/material.dart';
import 'package:colors_blind/core/extensions/context/media_query.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/presentation/style/app_colors.dart';

class HomeNavBar extends StatefulWidget {
  final NavBarStyle? style;
  final List<NavItem> items;
  final int currentIndex;
  final Function(int index) onTap;

  const HomeNavBar({
    super.key,
    required this.onTap,
    required this.items,
    required this.currentIndex,
    this.style,
  });

  @override
  State<HomeNavBar> createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  late NavBarStyle style;
  late int maximumTextLenght;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    style = widget.style ?? NavBarStyle();
    return IntrinsicHeight(
      child: Container(
        width: context.screenWidth,
        decoration: BoxDecoration(
          color: style.backgroundColor,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 215, 215, 215),
              spreadRadius: 0.5,
              blurRadius: 1,
              offset: Offset(0,-0.5,),
            ),
          ],
        ),
        padding: EdgeInsetsGeometry.only(
          top: 10.staticHeight,
          bottom: Platform.isIOS ? 30.staticHeight : 25.staticHeight,
        ),

        child: Row(
          spacing: context.screenWidth > 500 ? 25.staticWidth : 0,
          mainAxisAlignment: context.screenWidth > 500 ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
          children: [
            context.screenWidth > 500 ? const Spacer() : const SizedBox.shrink(),

            ...List.generate(
              widget.items.length,(index){
                return Column(
                  children: [
                    // icon
                    GestureDetector(
                      onTap: () {
                        widget.onTap(index);
                        if (widget.items[index].onTap != null) {
                          widget.items[index].onTap!(context);
                        }
                      },
                    
                      child: widget.currentIndex == index ? Container(
                        width: 40.fromRadius.max(50),
                        height: 40.fromRadius.max(50),
                        decoration: BoxDecoration(
                          color: style.selectedColor,
                          shape: BoxShape.circle,
                        ),

                        child: Icon(
                          widget.items[index].icon,
                          color: AppColors.white,
                          size: 25.fromRadius.max(27),
                        ),
                      ) : Icon(
                        widget.items[index].icon,
                        color: style.unselectedColor,
                        size: style.iconsSize,
                      ),
                    ),

                    // space between
                    SizedBox(height: style.textIconSpace,),

                    // text
                    widget.currentIndex != index ? Text(
                      widget.items[index].text,
                      style: style.textStyle,
                    ) : const SizedBox.shrink(),
                  ],
                );
              },
            ),

            context.screenWidth > 500 ? const Spacer() : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class NavItem{
  final IconData? icon;
  final ImageProvider? image;
  final String text;
  final void Function(BuildContext context)? onTap;

  NavItem({this.icon,this.text = '',this.image,this.onTap,}) {
    if (icon == null && image == null) {
      throw ArgumentError('Either icon or image must be provided.');
    }
  }
}

class NavBarStyle {
  final Color selectedColor;
  final Color unselectedColor;
  final Color backgroundColor;
  final double innerSpaces;
  final double iconsSize;
  final TextStyle? textStyle;
  final double textIconSpace;
  final BoxDecoration? decoration;

  const NavBarStyle({
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.innerSpaces = 0,
    this.iconsSize = 25,
    this.textStyle,
    this.textIconSpace = 5,
    this.decoration,
  });
}
