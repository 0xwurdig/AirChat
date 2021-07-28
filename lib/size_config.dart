import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SizeConfig {
  static double screenWidth;
  static double w;
  static double wR;
  static double screenHeight;
  static double textFactor;
  static double h;
  static double hR;

  static double heightMultiplier;
  static double widthMultiplier;
  static bool isPortrait = true;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      w = 411.4;
      h = 820.6;
      textFactor = Get.textScaleFactor;
      screenWidth = constraints.maxWidth > 411.4
          ? constraints.maxWidth / 411.4
          : textFactor;
      screenHeight = constraints.maxHeight > 820.6
          ? constraints.maxHeight / 820.6
          : textFactor;
      isPortrait = true;
    }
  }
}

// Get the proportionate height as per screen size
double getHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return inputHeight * screenHeight;
}

// Get the proportionate height as per screen size
double getWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return inputWidth * screenWidth;
}

double getText(double inputWidth) {
  double textFactor = SizeConfig.textFactor;
  // 375 is the layout width that designer use
  return inputWidth * textFactor;
}
