import 'dart:io';

import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;
  bool get isKeyboardOpen => MediaQuery.of(this).viewInsets.bottom == 0;
  bool get is24HoursMode => MediaQuery.of(this).alwaysUse24HourFormat;
  DeviceOrientation get orientation {
    if (screenWidth > screenHeight) {
      return DeviceOrientation.landscape;
    }
    else{
      return DeviceOrientation.portrait;
    }
  }
  DeviceType get deviceType {
    if (screenWidth > 500) {
      return DeviceType.tablet;
    }
    else{
      return DeviceType.mobile;
    }
  }
  DevicePlatformType get platform {
    if (Platform.isAndroid) {
      return DevicePlatformType.android;
    }
    else{
      return DevicePlatformType.iOS;
    }
  }
}

enum DeviceOrientation {
  portrait,
  landscape,
}

enum DeviceType {
  mobile,
  tablet,
}

enum DevicePlatformType {
  android,
  iOS,
}