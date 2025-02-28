import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final deviceInfo = getIt<DeviceInfo>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.semiBold24(deviceInfo, AppColors.appDarkBlue),
        ),
        SizedBox(
          height: deviceInfo.screenHeight * 0.01,
        ),
        Text(
          subtitle,
          style: TextStyles.mediumDark16.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}
