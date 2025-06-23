import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

////////////////❌❌❌❌❌❌❌❌❌///////////////////
//ToDo: Some Sizes are with screenWidth and some are with screenHeight
//This causes some issues with different models like Ipad
///////////////////////////////

class TextStyles {
  static final TextStyle semiBoldDark32 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins',
    color: AppColors.appDarkBlue,
  );
  static final TextStyle mediumDark16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: AppColors.appDarkBlue,
  );
  static final TextStyle mediumWhite18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: Colors.white,
  );
  static final TextStyle mediumWhite16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: Colors.white,
  );
  static final TextStyle mediumDark18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: AppColors.appDarkBlue,
  );

  // those functions are made with approximation
  static TextStyle semiBold24(DeviceInfo deviceInfo, Color color) {
    return TextStyle(
      fontSize: deviceInfo.screenWidth * 0.068,
      color: color,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle semiBold12(DeviceInfo deviceInfo, Color color) {
    return TextStyle(
      fontSize: deviceInfo.screenWidth * 0.035,
      color: color,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle regular14(DeviceInfo deviceInfo, Color color) {
    return TextStyle(
      fontSize: deviceInfo.screenWidth * 0.035,
      color: color,
      fontWeight: FontWeight.w400,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle regular10(DeviceInfo deviceInfo, Color color) {
    return TextStyle(
      fontSize: deviceInfo.screenWidth * 0.021,
      color: color,
      fontWeight: FontWeight.w400,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle regular12(DeviceInfo deviceInfo, Color color) {
    return TextStyle(
      fontSize: deviceInfo.screenWidth * 0.028,
      color: color,
      fontWeight: FontWeight.w400,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle regular16(DeviceInfo deviceInfo, Color color) {
    return TextStyle(
      fontSize: deviceInfo.screenWidth * 0.045,
      color: color,
      fontWeight: FontWeight.w400,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle semiBold16(DeviceInfo deviceInfo, Color color) {
    return TextStyle(
      fontSize: deviceInfo.screenHeight * 0.02,
      color: color,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle semiBold18(DeviceInfo deviceInfo, Color color) {
    return TextStyle(
      fontSize: deviceInfo.screenHeight * 0.025,
      color: color,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle semiBold20(DeviceInfo deviceInfo, Color color) {
    return TextStyle(
      fontSize: deviceInfo.screenHeight * 0.03,
      fontFamily: 'Poppins',
      color: color,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle bold20(DeviceInfo deviceInfo, Color color) {
    return TextStyle(
      fontSize: deviceInfo.screenHeight * 0.03,
      fontFamily: 'Poppins',
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle bold24(DeviceInfo deviceInfo, Color color) {
    return TextStyle(
      fontSize: deviceInfo.screenHeight * 0.03,
      fontFamily: 'Poppins',
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle bold34(DeviceInfo deviceInfo, Color color) {
    return TextStyle(
      fontSize: deviceInfo.screenHeight * 0.04,
      fontFamily: 'Poppins',
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle bold75(DeviceInfo deviceInfo, Color color) {
    return TextStyle(
      fontSize: deviceInfo.screenHeight * 0.065,
      fontFamily: 'Poppins',
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle medium20(DeviceInfo deviceInfo, Color color) {
    return TextStyle(
      fontSize: deviceInfo.screenHeight * 0.026,
      color: color,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle medium16(DeviceInfo deviceInfo, Color color) {
    return TextStyle(
      fontSize: deviceInfo.screenHeight * 0.0185,
      color: color,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle medium12(DeviceInfo deviceInfo, Color color) {
    return TextStyle(
      fontSize: deviceInfo.screenHeight * 0.016,
      color: color,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle constrainedSize(
      double size, Color color, FontWeight fontWeight) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
      fontFamily: 'Poppins',
    );
  }
}
