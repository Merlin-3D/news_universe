import 'package:flutter/material.dart';

extension SizeExtension on num {
  double get h =>
      (this / 812) *
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
  double get w =>
      (this / 375) *
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
}
