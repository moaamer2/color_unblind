import 'dart:math';

import 'package:flutter/material.dart';

extension Fractions on double {
  double roundFractions(int digits) {
    double mod = pow(10.0, digits).toDouble();
    return ((this * mod).round().toDouble() / mod);
  }

  Widget get vGap => SizedBox(height: this);
  Widget get hGap => SizedBox(width: this);
}
