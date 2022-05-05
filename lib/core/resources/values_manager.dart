import 'package:flutter/material.dart';

final size = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
final deviceHeight = size.size.height;
final deviceWidth = size.size.width;

class AppPadding {
  static const double p0 = 0.0;
  static const double p4 = 4.0;
  static const double p8 = 8.0;
  static const double p12 = 12.0;
  static const double p16 = 16.0;
  static const double p20 = 20.0;
  static const double p24 = 24.0;
}

class AppSize {
  static const double s0 = 0.0;
  static const double s1_2 = 1.2;
  static const double s1_5 = 1.5;
  static const double s2 = 2.0;
  static const double s3 = 3.0;
  static const double s4 = 4.0;
  static const double s8 = 8.0;
  static const double s10 = 10.0;
  static const double s12 = 12.0;
  static const double s16 = 16.0;
  static const double s24 = 24.0;
}

class Time {
  static const Duration t0 = Duration(milliseconds: 0);
  static const Duration t100 = Duration(milliseconds: 100);
  static const Duration t150 = Duration(milliseconds: 150);
  static const Duration t300 = Duration(milliseconds: 300);
  static const Duration t700 = Duration(milliseconds: 700);
  static const Duration t1000 = Duration(seconds: 1);
  static const Duration t2000 = Duration(seconds: 2);
}
