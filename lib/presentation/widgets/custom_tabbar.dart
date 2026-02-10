import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/presentation/style/app_colors.dart';
import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';

class CustomTabbar<T> extends StatefulWidget {
  final TabbrTheme? tabbrTheme;
  final List<T> items;
  final double? tabWidth;
  final double? height;
  final int currentIndex;
  final void Function(T value,int index) onTap;
  final void Function(T value)? defaultCommand;
  final String Function(T value)? getLable;
  final TabbarBehavior behavior;

  const CustomTabbar({
    super.key,
    this.tabbrTheme,
    required this.items,
    this.currentIndex = 0,
    this.tabWidth,
    this.height,
    required this.onTap,
    this.defaultCommand,
    this.getLable,
    this.behavior = TabbarBehavior.singleSelect,
  });

  factory CustomTabbar.colorsBlind(
    BuildContext context, {
      required List<T> items,
      int currentIndex = 0,
      double? tabWidth,
      double? height,
      required void Function(T value,int index) onTap,
      void Function(T value)? defaultCommand,
      String Function(T value)? getLable,
      TabbarBehavior behavior = TabbarBehavior.singleSelect,  
    }
  ){
    final themeCubit = context.read<ThemeCubit>();

    return CustomTabbar<T>(
      items: items,
      currentIndex: currentIndex,
      tabWidth: tabWidth,
      height: height,
      onTap: onTap,
      defaultCommand: defaultCommand,
      getLable: getLable,
      behavior: behavior,
      tabbrTheme: TabbrTheme(
        backgroundColor: AppColors.transparent,
        selectedColor: themeCubit.state.primaryColor,
        unselectedColor: AppColors.darkGrey,
        activeStyle: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12.textScale,
        ),
        style: TextStyle(
          color: themeCubit.state.textColor,
          fontSize: 12.textScale,
        ),
      ),
    );
  }

  @override
  State<CustomTabbar> createState() => _CustomTabbarState<T>();
}

class _CustomTabbarState<T> extends State<CustomTabbar<T>> {
  late int currentIndex;
  late TabbrTheme theme;
  List<int> currentIndexList = [];
  @override
  void initState() {
    switch (widget.behavior){
      case TabbarBehavior.singleSelect:
        currentIndex = -1;
        break;
      case TabbarBehavior.multiSelect:
        currentIndexList = [];
        break;
      case TabbarBehavior.singleSelectNonEmpty:
        if (widget.currentIndex < 0 || widget.currentIndex >= widget.items.length){
          currentIndex = 0;
        }
        else{
          currentIndex = widget.currentIndex;
        }
        break;
      case TabbarBehavior.multiSelectNonEmpty:
        if (widget.currentIndex < 0 || widget.currentIndex >= widget.items.length){
          currentIndexList = [0];
        }
        else{
          currentIndexList = [widget.currentIndex];
        }
        break;
    }
    _initTheme();
    super.initState();
  }
  void _initTheme(){
    if (widget.tabbrTheme == null){
      theme = widget.tabbrTheme ?? TabbrTheme(
        backgroundColor: Colors.transparent,
        selectedColor: Colors.blue,
        unselectedColor: Colors.grey
      );
    }
    else{
      theme = widget.tabbrTheme!;
    }
  }
  bool _isTabActive(int index){
    switch (widget.behavior){
      case TabbarBehavior.singleSelect || TabbarBehavior.singleSelectNonEmpty:
        return currentIndex == index;
      case TabbarBehavior.multiSelect || TabbarBehavior.multiSelectNonEmpty:
        return currentIndexList.contains(index);
    }
  }
  void _activeTab(int index){
    switch (widget.behavior){
      case TabbarBehavior.singleSelect || TabbarBehavior.singleSelectNonEmpty:
        currentIndex = index;
        break;
      case TabbarBehavior.multiSelect || TabbarBehavior.multiSelectNonEmpty:
        currentIndexList.add(index);
        break;
    }
    widget.onTap(widget.items[index],index);
  }
  void _deactiveTab(int index){
    switch (widget.behavior){
      case TabbarBehavior.singleSelect:
        currentIndex = -1;
        if (widget.defaultCommand != null){
          widget.defaultCommand!(widget.items[index]);
        }
        break;
      case TabbarBehavior.singleSelectNonEmpty:
        break;
      case TabbarBehavior.multiSelect:
        currentIndexList.remove(index);
        if (widget.defaultCommand != null){
          widget.defaultCommand!(widget.items[index]);
        }
        break;
      case TabbarBehavior.multiSelectNonEmpty:
        if (currentIndexList.length > 1){
          currentIndexList.remove(index);
          if (widget.defaultCommand != null){
            widget.defaultCommand!(widget.items[index]);
          }
        }
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    _initTheme();
    return Container(
      color: Colors.transparent,
      height: widget.height ?? 40.staticHeight,
      child: ListView.builder(
        itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){
              setState((){
                if (_isTabActive(index)){
                  _deactiveTab(index);
                }
                else{
                  _activeTab(index);
                }
              });
            },
            child: Row(
              children: [
                Container(
                  width: widget.tabWidth != null ? (widget.tabWidth! + (_isTabActive(index) ? 25 : 0)) : null,
                  decoration: BoxDecoration(
                    color:  _isTabActive(index) ? theme.selectedColor : theme.backgroundColor,
                    borderRadius: BorderRadius.circular(47),
                    border: Border.all(
                      width: 1.5.fromRadius.max(2),
                      color: _isTabActive(index) ? theme.selectedColor : theme.unselectedColor,
                    ),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10.staticWidth,vertical: 5.staticHeight),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      widget.getLable == null ? widget.items[index].toString() : widget.getLable!(widget.items[index]),
                      style: (_isTabActive(index) ? theme.activeStyle : theme.style)?.copyWith(
                        color: _isTabActive(index) ? theme.activeStyle?.color : theme.unselectedColor,
                        fontWeight: _isTabActive(index) ? FontWeight.bold : null,
                      ),
                    ),
                  ),
                ),
    
                // space between the tabs
                SizedBox(width: 8.staticWidth,)
              ],
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}


class TabbrTheme {
  final Color backgroundColor;
  final Color selectedColor;
  final Color unselectedColor;
  final TextStyle? style;
  final TextStyle? activeStyle;

  TabbrTheme({
    required this.backgroundColor,
    required this.selectedColor,
    required this.unselectedColor,
    this.style,
    this.activeStyle
  });
}

enum TabbarBehavior {
  multiSelect,
  multiSelectNonEmpty,
  singleSelect,
  singleSelectNonEmpty
}