import 'package:flutter/material.dart';

class DeviceInfo {
  Orientation orientation;
  double screenWidth;
  double screenHeight;
  final ValueNotifier<bool> _notifier =
      ValueNotifier(true); // Dummy value to trigger updates

  DeviceInfo({
    required this.orientation,
    required this.screenWidth,
    required this.screenHeight,
  });

  // Method to update properties dynamically
  void updateFromContext(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
    orientation = mediaQuery.orientation;
    _notifier.value = !_notifier.value; // Toggle to notify listeners
  }

  // Expose the notifier for ValueListenableBuilder
  ValueNotifier<bool> get notifier => _notifier;
}
