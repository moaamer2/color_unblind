import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
class AdaptiveLoadingIndicator extends StatelessWidget{
  final double iOSsize;
  final double androidSize;
  final Color color;
  final double androidWidth;

  const AdaptiveLoadingIndicator({
    super.key,
    this.androidSize = 22,
    this.androidWidth = 4,
    this.iOSsize = 12,
    this.color = Colors.white,
  });

  factory AdaptiveLoadingIndicator.bigButton(){
    return AdaptiveLoadingIndicator(
      androidSize: 21,
      androidWidth: 4,
      iOSsize: 11,
      color: Colors.white,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS ? CupertinoActivityIndicator(
        color: color,
        radius: iOSsize.textScale,
      ) : SizedBox(
        width: androidSize.textScale,
        height: androidSize.textScale,
        child: CircularProgressIndicator(
          strokeWidth: androidWidth.textScale,
          color: color,
        ),
      ),
    );
  }
}
