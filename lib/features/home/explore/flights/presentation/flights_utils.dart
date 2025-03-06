import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';

class FlightsUtils {
  static final deviceInfo = getIt<DeviceInfo>();

  //Styles
  static final titleStyle = TextStyles.semiBold18(deviceInfo, Colors.white);
  static final subTitleStyle = TextStyles.bold34(deviceInfo, Colors.white);
  static final radiotileTextStyle =
      TextStyles.semiBold18(deviceInfo, Colors.black);

  //Dimensions
  static final backGroundBorderRadius = deviceInfo.screenHeight * 0.05;
  static final radioTilesRowWidth = deviceInfo.screenWidth * 0.75;
}
