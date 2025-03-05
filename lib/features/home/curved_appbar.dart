import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

final deviceInfo = getIt<DeviceInfo>();

class CurvedAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final void Function() onBack;
  const CurvedAppbar({super.key, required this.title, required this.onBack});
  @override
  Size get preferredSize => Size.fromHeight(
        deviceInfo.screenHeight > deviceInfo.screenWidth
            ? deviceInfo.screenHeight * 0.06
            : deviceInfo.screenWidth * 0.05,
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(deviceInfo.screenWidth * 0.08),
          bottomLeft: Radius.circular(deviceInfo.screenWidth * 0.08),
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyles.medium20(deviceInfo, Colors.white),
      ),
      leading: Padding(
        padding: EdgeInsets.only(left: deviceInfo.screenWidth * 0.02),
        child: IconButton(
            onPressed: onBack,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
    );
  }
}
