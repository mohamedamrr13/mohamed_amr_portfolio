import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xff64FFDA);
  static const Color primaryColorDark = Color(0xff0A0E27);
  static const Color buttonColorDark = Color(0xff1E2749);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color grey = Color(0xff9CABBA);
  static const Color darkGrey = Color(0xff2D3748);
  static const Color lightGrey = Color(0xffE2E8F0);

  // Gradient colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, Color(0xff4FD1C7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [primaryColorDark, Color(0xff1A1A2E)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
