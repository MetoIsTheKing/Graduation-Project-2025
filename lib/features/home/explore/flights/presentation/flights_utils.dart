import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

final deviceInfo = getIt<DeviceInfo>();

class FlightsUtils {
  ///////////////////////////// Styles ////////////////////////////////////
  static final titleStyle =
      TextStyles.semiBold18(getIt<DeviceInfo>(), Colors.white);
  static final subTitleStyle = TextStyles.bold34(deviceInfo, Colors.white);
  static final radiotileTextStyle =
      TextStyles.semiBold18(deviceInfo, AppColors.appBlack)
          .copyWith(fontSize: deviceInfo.screenWidth * 0.03);
  static final fieldLabelStyle =
      TextStyles.semiBold18(deviceInfo, AppColors.appBlack)
          .copyWith(fontSize: deviceInfo.screenWidth * 0.03);
  static final cardLabelStyle = TextStyles.regular16(deviceInfo, Colors.white)
      .copyWith(fontSize: deviceInfo.screenWidth * 0.03);
  static final TextStyle hintTextStyle = TextStyles.mediumDark16
      .copyWith(fontSize: deviceInfo.screenWidth * 0.03, color: Colors.grey);
  static final TextStyle fieldInputStyle = TextStyles.mediumDark16
      .copyWith(fontSize: deviceInfo.screenWidth * 0.03, color: Colors.black);
  ///////////////////////////// Styles ////////////////////////////////////

  ///////////////////////////// Dimensions ////////////////////////////////////

  static final backGroundBorderRadius = deviceInfo.screenHeight * 0.05;
  static final radioTilesRowWidth = deviceInfo.screenWidth * 0.75;
  static final double fieldBorderRaduis = deviceInfo.screenHeight * 0.02;
  static final double cardBorderRadius = deviceInfo.screenHeight * 0.02;
  static final double deleteButtonBorderRadius = deviceInfo.screenHeight * 0.05;
  static final double firstPageHeight = deviceInfo.screenHeight * 0.4;
  static final double secondPageHeight = deviceInfo.screenHeight * 0.63;
  static final double thirdPageHeight = deviceInfo.screenHeight * 0.45;

  ///////////////////////////// Dimensions ////////////////////////////////////

  ///////////////////////////// Paddings ////////////////////////////////////

  static final EdgeInsets cardHeaderPadding = EdgeInsets.symmetric(
    horizontal: deviceInfo.screenWidth * 0.03,
    vertical: deviceInfo.screenHeight * 0.01,
  );
  static final EdgeInsets cardContentPadding = EdgeInsets.symmetric(
    horizontal: deviceInfo.screenWidth * 0.03,
    vertical: deviceInfo.screenHeight * 0.02,
  );
  static final EdgeInsets subTitlePadding = EdgeInsets.symmetric(
    horizontal: deviceInfo.screenWidth * 0.05,
    vertical: deviceInfo.screenHeight * 0.03,
  );
  static final EdgeInsets whiteContainerPadding = EdgeInsets.symmetric(
    horizontal: deviceInfo.screenWidth * 0.02,
    vertical: deviceInfo.screenHeight * 0.01,
  );
  static final EdgeInsets mainContentPadding = EdgeInsets.symmetric(
    horizontal: deviceInfo.screenWidth * 0.05,
    vertical: deviceInfo.screenHeight * 0.02,
  );
  ///////////////////////////// Paddings ////////////////////////////////////

  ///////////////////////////// Durations ////////////////////////////////////

  static final Duration horizontalAnimationDuration =
      Duration(milliseconds: 300);
  static final Duration verticalAnimationDuration = Duration(milliseconds: 250);

  ///////////////////////////// Durations ////////////////////////////////////

  ///////////////////////////// Widgets ////////////////////////////////////

  ///////////////////////////// Widgets ////////////////////////////////////
}
