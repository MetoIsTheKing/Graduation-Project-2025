import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';

// device info instance
final deviceInfo = getIt<DeviceInfo>();

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool backButtonVisible;
  final void Function() onPressed;

  const AuthAppBar({super.key, required this.backButtonVisible, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: deviceInfo.screenHeight > deviceInfo.screenWidth
          ? deviceInfo.screenHeight * 0.05
          : deviceInfo.screenWidth * 0.05,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Visibility(
        visible: backButtonVisible,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.appBlue,
            size: deviceInfo.screenHeight > deviceInfo.screenWidth
                ? deviceInfo.screenWidth * 0.07
                : deviceInfo.screenHeight * 0.09,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        deviceInfo.screenHeight > deviceInfo.screenWidth
            ? deviceInfo.screenHeight * 0.05
            : deviceInfo.screenWidth * 0.05,
      );
}
