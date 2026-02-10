import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  final WidgetBuilder mobile;
  final WidgetBuilder? landscapeMobile;
  final WidgetBuilder? portraitTablet;
  final WidgetBuilder? landscapeTablet;
  final WidgetBuilder? desktop;
  final WidgetBuilder? tv;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.landscapeMobile,
    this.portraitTablet,
    this.landscapeTablet,
    this.desktop,
    this.tv,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        switch (context.deviceType) {
          case _DeviceType.mobile:
            switch (context.orientation) {
              case _DeviceOrientation.portrait:
                return mobile(context);
              case _DeviceOrientation.landscape:
                final builder = landscapeMobile ?? landscapeTablet ?? mobile;
                return builder(context);
            }
          case _DeviceType.tablet:
            switch (context.orientation) {
              case _DeviceOrientation.portrait:
                final builder = portraitTablet ?? mobile;
                return builder(context);
              case _DeviceOrientation.landscape:
                final builder = landscapeTablet ?? portraitTablet ?? mobile;
                return builder(context);
            }
          case _DeviceType.desktop:
            final builder = desktop ?? landscapeTablet ?? portraitTablet ?? mobile;
            return builder(context);
          case _DeviceType.tv:
            final builder = tv ?? landscapeTablet ?? portraitTablet ?? desktop ?? mobile;
            return builder(context);
        }
      },
    );
  }
}

extension _MediaQueryExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;
  _DeviceOrientation get orientation {
    if (screenWidth > screenHeight) {
      return _DeviceOrientation.landscape;
    }
    else{
      return _DeviceOrientation.portrait;
    }
  }
  _DeviceType get deviceType {
    if (screenWidth > 500) {
      return _DeviceType.tablet;
    }
    else{
      return _DeviceType.mobile;
    }
  }
}

enum _DeviceOrientation {
  portrait,
  landscape,
}

enum _DeviceType {
  mobile,
  tablet,
  desktop,
  tv,
}