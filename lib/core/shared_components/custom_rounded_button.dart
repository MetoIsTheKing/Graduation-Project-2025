import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';

class CustomRoundedButton extends StatelessWidget {
  final DeviceInfo deviceInfo;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;
  const CustomRoundedButton({
    super.key,
    required this.deviceInfo,
    required this.label,
    required this.backgroundColor,
    required this.onPressed,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: deviceInfo.screenHeight * 0.04),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(backgroundColor),
          fixedSize: WidgetStatePropertyAll(
            Size(deviceInfo.screenWidth, deviceInfo.screenHeight * 0.055),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyles.mediumWhite18.copyWith(color: textColor),
        ),
      ),
    );
  }
}
