import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppColors {
  static const Color darkPurple = Color(0xFF3D2645);
  static const Color purple = Color(0xFF832161);
  static const Color pink = Color(0xFFDA4167);

  static const Color red = Color(0xFFD42424);
  static const Color orange = Color(0xFFDE7C33);
  static const Color yellow = Color(0xFFE8E043);
  static const Color lightGreen = Color(0xFFB2E552);
  static const Color green = Color(0xFF7DE95F);

  static const Color grey = Color(0xFFF0EFF4);
}

class AppGradients {
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [
      AppColors.darkPurple,
      Colors.black,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
