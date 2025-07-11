import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

final deviceInfo = getIt<DeviceInfo>();

class SearchCustomTile extends StatelessWidget {
  final String title;
  final String tileIconPath;
  final Color tileFillColor;
  final Color tileBorderColor;
  final void Function()? onTap;
  final Widget? subtitle;
  const SearchCustomTile({
    super.key,
    this.onTap,
    required this.title,
    required this.tileIconPath,
    required this.tileFillColor,
    this.subtitle,
    required this.tileBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      minVerticalPadding: deviceInfo.screenHeight * 0.015,
      minTileHeight: deviceInfo.screenWidth * 0.15,
      tileColor: tileFillColor,
      subtitle: subtitle,
      horizontalTitleGap: deviceInfo.screenWidth * 0.025,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: tileBorderColor, width: 1),
      ),
      onTap: onTap,
      leading: Image.asset(
        tileIconPath,
        height: deviceInfo.screenHeight * 0.04,
        width: deviceInfo.screenHeight * 0.04,
      ),
      title: Text(
        title,
        style: TextStyles.medium16(deviceInfo, AppColors.appDarkBlue)
            .copyWith(overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
