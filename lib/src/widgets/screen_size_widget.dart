import 'package:flutter/material.dart';

class ScreenSize {
  static double _screenWidth = 0;
  static double _screenHeight = 0;
  static double _blockWidth = 0;
  static double _blockHeight = 0;
  static double textMultipler = 0;
  static double imageSizeMultiplier = 0;
  static double height = 0;
  static double width = 0;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BoxConstraints constraints, Orientation orientation){
    if(orientation == Orientation.portrait){
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
      if(_screenWidth < 450) isMobilePortrait = true;
    } else{
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }
    _blockWidth = _screenWidth / 100;
    _blockHeight = _screenHeight / 100;
    textMultipler = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    height = _blockHeight;
    width = _blockWidth;
  }
}