import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Theme {
  /**
   * 登录界面，定义渐变的颜色
   */
  static const Color loginGradientEnd = Vx.orange400;
  static const Color loginGradientStart = Vx.purple500;

  static const LinearGradient primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}