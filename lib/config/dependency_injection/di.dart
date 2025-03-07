import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart' as my_device_info;

final getIt = GetIt.instance;


Future<void> initDependencies() async {
  // Register DeviceInfo as a singleton with initial default values
  if (!getIt.isRegistered<my_device_info.DeviceInfo>()) {
    getIt.registerSingleton<my_device_info.DeviceInfo>(
      my_device_info.DeviceInfo(
        orientation: Orientation.portrait,
        deviceType: DeviceType.phone, // Changed to match your enum
        screenWidth: 0.0,
        screenHeight: 0.0,
      ),
    );
  }
}