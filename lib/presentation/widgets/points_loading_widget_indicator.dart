import 'dart:async';
import 'package:flutter/material.dart';

class PointsLoadingWidgetIndicator extends StatefulWidget {
  final double size;
  final Color color;
  final Color shadingColor;
  final int countIndicators;

  const PointsLoadingWidgetIndicator({
    super.key,
    this.size = 10,
    this.countIndicators = 3,
    this.color = Colors.blue,
    this.shadingColor = Colors.lightBlue,
  });

  @override
  State<PointsLoadingWidgetIndicator> createState() => _PointsLoadingWidgetIndicatorState();
}

class _PointsLoadingWidgetIndicatorState extends State<PointsLoadingWidgetIndicator> {
  int activeIndex = 0;
  late StreamSubscription<int> subscription;

  @override
  void initState() {
    super.initState();
    subscription = startLoading().listen((index) {
      setState(() {
        activeIndex = index;
      });
    });
  }

  Stream<int> startLoading() async* {
    while (true) {
      yield activeIndex = (activeIndex + 1) % widget.countIndicators;
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
      widget.countIndicators,
        (index){
          return Container(
            width: widget.size,
            height: widget.size,
            margin: EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == activeIndex ? widget.color : widget.shadingColor,
            ),
          );
        }
      ),
    );
  }
}
