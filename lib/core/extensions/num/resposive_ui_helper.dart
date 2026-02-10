import 'package:flutter_screenutil/flutter_screenutil.dart';

extension RsponsiveUiHelperExtension on num {
  double get fromWidth => w;
  double get fromHeight => h;
  double get fromRadius => r;
  double get textScale {
    // final scaleFactor = ScreenUtil().textScaleFactor;
    double responsiveText = fromRadius;

    final lower = this * 0.8;
    final upper = this * 1.2;

    return responsiveText.clamp(lower, upper);
  }

  double get staticHeight => h.max(this * 1);
  double get staticWidth => w.max(this * 1);
  double get staticRadius => r.max(this * 1);

  double max(double maxValue){
    return toDouble() > maxValue ? maxValue : toDouble();
  }
}