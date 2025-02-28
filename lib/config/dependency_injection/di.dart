import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation_project_2025/core/responsive/Functions/get_device_type.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  
}

void setupContextDependentDependencies(BuildContext context) {
  if (!getIt.isRegistered<DeviceInfo>()) {
    final mediaQuery = MediaQuery.of(context);

    final deviceInfo = DeviceInfo(
      orientation: mediaQuery.orientation,
      deviceType: getDeviceType(mediaQuery),
      screenWidth: mediaQuery.size.width,
      screenHeight: mediaQuery.size.height,
    );

    // Register DeviceInfo as a singleton
    getIt.registerSingleton<DeviceInfo>(deviceInfo);
  }
}