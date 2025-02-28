import 'package:flutter/material.dart';

import '../enums/device_type.dart';

class DeviceInfo {
  final Orientation orientation;
  final DeviceType deviceType;
  final double screenWidth;
  final double screenHeight;

  DeviceInfo({
    required this.orientation,
    required this.deviceType,
    required this.screenWidth,
    required this.screenHeight,
  });
}