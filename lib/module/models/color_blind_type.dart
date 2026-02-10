enum ColorBlindType {
  normal,
  protanopia,
  deuteranopia,
  tritanopia,
}


extension ColorBlindTypeExtension on ColorBlindType {
  int get value {
    switch (this) {
      case ColorBlindType.protanopia:
        return 1;
      case ColorBlindType.deuteranopia:
        return 2;
      case ColorBlindType.tritanopia:
        return 3;
      case ColorBlindType.normal:
        return 0;
    }
  }
}