import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

class SectionLabel extends StatelessWidget {
  final DeviceInfo deviceInfo;
  final String label;
  final void Function()? onTap;
  const SectionLabel(
      {super.key, required this.label, required this.deviceInfo, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: deviceInfo.screenHeight * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyles.semiBold16(deviceInfo, AppColors.appDarkBlue),
          ),
          GestureDetector(
              onTap: onTap,
              child: Text('See all',
                  style: TextStyles.regular14(deviceInfo, AppColors.appBlue))),
        ],
      ),
    );
  }
}
