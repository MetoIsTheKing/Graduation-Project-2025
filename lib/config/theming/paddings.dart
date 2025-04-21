import 'package:flutter/material.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';

class Paddings {
  static EdgeInsets authMainPagePadding(DeviceInfo deviceInfo) {
    return EdgeInsets.symmetric(
      vertical: deviceInfo.screenHeight * 0.01,
      horizontal: deviceInfo.screenWidth * 0.04,
    );
  }
}
