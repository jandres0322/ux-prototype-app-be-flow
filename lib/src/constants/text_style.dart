import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ux_prototype_app_be_flow/src/constants/colors.dart';

class AppTextStyle {
  static final String? _popins = GoogleFonts.poppins().fontFamily;
  static final String? _sedwickAve = GoogleFonts.sedgwickAve().fontFamily;
  static final TextStyle numberTempo = TextStyle(
    fontFamily: _popins,
    fontWeight: FontWeight.bold,
    fontSize: 55
  );
  static final TextStyle numberConfigPomodoro = TextStyle(
    fontFamily: _popins,
    fontWeight: FontWeight.w400,
    fontSize: 45
  );
  static final TextStyle titleModals = TextStyle(
    fontFamily: _popins,
    fontWeight: FontWeight.w500,
    fontSize: 24,
    color: AppColors.primary
  );
  static final TextStyle titleListTasks = TextStyle(
    fontFamily: _popins,
    fontWeight: FontWeight.bold,
    fontSize: 18
  );
  static final TextStyle textBodyListTasks = TextStyle(
    fontFamily: _popins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: AppColors.primary
  );
  static final TextStyle textTextsButtons = TextStyle(
    fontFamily: _popins,
    fontWeight: FontWeight.w500,
    fontSize: 13
  );
  static final TextStyle textPlaceholder = TextStyle(
    fontFamily: _popins,
    fontWeight: FontWeight.w200,
    fontSize: 13,
  );
  static final TextStyle bigButtons = TextStyle(
    fontFamily: _sedwickAve,
    fontWeight: FontWeight.w400,
    fontSize: 48
  );
  static final TextStyle numbersConfig = TextStyle(
    fontFamily: _sedwickAve,
    fontWeight: FontWeight.w400,
    fontSize: 32
  );
  static TextStyle withColor(TextStyle textStyle, Color color) {
    return textStyle.copyWith(color: color);
  }
}