import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

final deviceInfo = getIt<DeviceInfo>();

class CurrentLocationTile extends StatelessWidget {
  final void Function()? onTap;
  const CurrentLocationTile({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: deviceInfo.screenWidth * 0.025,
      contentPadding: EdgeInsets.symmetric(
        vertical: deviceInfo.screenHeight * 0.0005,
        horizontal: deviceInfo.screenWidth * 0.03,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey, width: 1),
      ),
      onTap: onTap,
      leading: SvgPicture.asset(
        'assets/images/location_pin.svg',
        height: deviceInfo.screenHeight * 0.03,
        width: deviceInfo.screenHeight * 0.03,
      ),
      title: Text(
        'use current location',
        style: TextStyles.medium16(deviceInfo, AppColors.appDarkGrey),
      ),
    );
  }
}
