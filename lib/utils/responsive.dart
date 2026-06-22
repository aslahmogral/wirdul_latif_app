import 'package:flutter/material.dart';

extension ResponsiveExtension on BuildContext {
  bool get isTablet => MediaQuery.of(this).size.shortestSide >= 600;
  bool get isDesktop => MediaQuery.of(this).size.shortestSide >= 900;
  bool get isMobile => !isTablet && !isDesktop;

  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}
