// import 'package:flutter/material.dart';
// import 'package:graduation_project_2025/config/theming/text_styles.dart';
// import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
// import 'package:graduation_project_2025/core/utils/app_colors.dart';

// class FlightsUtils {
//   final DeviceInfo deviceInfo;

//   FlightsUtils(this.deviceInfo);

//   ///////////////////////////// Styles ////////////////////////////////////
//   TextStyle get titleStyle => TextStyles.semiBold18(deviceInfo, Colors.white);
//   TextStyle get subTitleStyle => TextStyles.bold34(deviceInfo, Colors.white);
//   TextStyle get radiotileTextStyle =>
//       TextStyles.semiBold18(deviceInfo, AppColors.appBlack)
//           .copyWith(fontSize: deviceInfo.screenWidth * 0.03);
//   TextStyle get fieldLabelStyle =>
//       TextStyles.semiBold18(deviceInfo, AppColors.appBlack)
//           .copyWith(fontSize: deviceInfo.screenWidth * 0.03);
//   TextStyle get cardLabelStyle => TextStyles.regular16(deviceInfo, Colors.white)
//       .copyWith(fontSize: deviceInfo.screenWidth * 0.03);
//   TextStyle get hintTextStyle => TextStyles.mediumDark16
//       .copyWith(fontSize: deviceInfo.screenWidth * 0.03, color: Colors.grey);
//   TextStyle get fieldInputStyle => TextStyles.mediumDark16
//       .copyWith(fontSize: deviceInfo.screenWidth * 0.03, color: Colors.black);
//   ///////////////////////////// Styles ////////////////////////////////////

//   ///////////////////////////// Dimensions ////////////////////////////////////
//   double get backGroundBorderRadius => deviceInfo.screenHeight * 0.05;
//   double get radioTilesRowWidth => deviceInfo.screenWidth * 0.75;
//   double get fieldBorderRaduis => deviceInfo.screenHeight * 0.02;
//   double get cardBorderRadius => deviceInfo.screenHeight * 0.02;
//   double get deleteButtonBorderRadius => deviceInfo.screenHeight * 0.05;
//   double get pageViewHeight => deviceInfo.screenHeight * 0.65;
//   double get listViewHeight => deviceInfo.screenHeight * 0.5;
//   ///////////////////////////// Dimensions ////////////////////////////////////

//   ///////////////////////////// Paddings ////////////////////////////////////
//   EdgeInsets get cardHeaderPadding => EdgeInsets.symmetric(
//         horizontal: deviceInfo.screenWidth * 0.03,
//         vertical: deviceInfo.screenHeight * 0.01,
//       );
//   EdgeInsets get cardContentPadding => EdgeInsets.symmetric(
//         horizontal: deviceInfo.screenWidth * 0.03,
//         vertical: deviceInfo.screenHeight * 0.02,
//       );
//   EdgeInsets get subTitlePadding => EdgeInsets.symmetric(
//         horizontal: deviceInfo.screenWidth * 0.05,
//         vertical: deviceInfo.screenHeight * 0.03,
//       );
//   EdgeInsets get whiteContainerPadding => EdgeInsets.symmetric(
//         horizontal: deviceInfo.screenWidth * 0.02,
//         vertical: deviceInfo.screenHeight * 0.001,
//       );
//   EdgeInsets get mainContentPadding => EdgeInsets.symmetric(
//         horizontal: deviceInfo.screenWidth * 0.05,
//         vertical: deviceInfo.screenHeight * 0.005,
//       );
//   ///////////////////////////// Paddings ////////////////////////////////////

//   ///////////////////////////// Durations ////////////////////////////////////
//   Duration get horizontalAnimationDuration => Duration(milliseconds: 300);
//   Duration get verticalAnimationDuration => Duration(milliseconds: 250);
//   ///////////////////////////// Durations ////////////////////////////////////

//   ///////////////////////////// Widgets ////////////////////////////////////
//   ///////////////////////////// Widgets ////////////////////////////////////
// }
