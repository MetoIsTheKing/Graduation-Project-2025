import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';

class TitleSubtitleWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final DeviceInfo deviceInfo;
  const TitleSubtitleWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.deviceInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.semiBoldDark32.copyWith(fontSize: 28),
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
