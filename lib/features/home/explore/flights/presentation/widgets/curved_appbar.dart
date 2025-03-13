import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';

final deviceInfo = getIt<DeviceInfo>();

class CurvedAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Color backButtonColor;
  final Widget titleWidget;
  final void Function() onBack;
  const CurvedAppbar(
      {super.key,
      required this.onBack,
      required this.backgroundColor,
      required this.titleWidget,
      required this.backButtonColor});
  @override
  Size get preferredSize => Size.fromHeight(
        deviceInfo.screenHeight > deviceInfo.screenWidth
            ? deviceInfo.screenHeight * 0.065
            : deviceInfo.screenWidth * 0.05,
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(deviceInfo.screenWidth * 0.08),
          bottomLeft: Radius.circular(deviceInfo.screenWidth * 0.08),
        ),
      ),
      centerTitle: true,
      title: titleWidget,
      leading: Padding(
        padding: EdgeInsets.only(left: deviceInfo.screenWidth * 0.02),
        child: IconButton(
            onPressed: onBack,
            icon: Icon(
              Icons.arrow_back,
              size: deviceInfo.screenWidth * 0.07,
              color: backButtonColor,
            )),
      ),
    );
  }
}

// Text(
//         title,
//         style: TextStyles.medium20(deviceInfo, Colors.white),
//       ),
