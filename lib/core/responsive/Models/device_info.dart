import 'package:flutter/material.dart';

import 'package:device_preview/device_preview.dart';

class DeviceInfo {
  Orientation orientation;
  DeviceType deviceType;
  double screenWidth;
  double screenHeight;
  final ValueNotifier<bool> _notifier = ValueNotifier(true); // Dummy value to trigger updates

  DeviceInfo({
    required this.orientation,
    required this.deviceType,
    required this.screenWidth,
    required this.screenHeight,
  });

  // Method to update properties dynamically
  void updateFromContext(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
    orientation = mediaQuery.orientation;
    deviceType = getDeviceType(mediaQuery); // Use your existing method
    _notifier.value = !_notifier.value; // Toggle to notify listeners
  }

  // Expose the notifier for ValueListenableBuilder
  ValueNotifier<bool> get notifier => _notifier;
}

// Your existing getDeviceType function (assuming it’s in get_device_type.dart)
DeviceType getDeviceType(MediaQueryData mediaQuery) {
  return mediaQuery.size.width > 600 ? DeviceType.tablet : DeviceType.phone;
}

// Fallback if getDeviceType isn’t available
DeviceType getDeviceTypeFromSize(Size size) {
  return size.width > 600 ? DeviceType.tablet : DeviceType.phone;
}