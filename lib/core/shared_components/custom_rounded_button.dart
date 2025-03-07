import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';

class CustomRoundedButton extends StatelessWidget {
  final DeviceInfo deviceInfo;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;
  final String? assetIcon;
  const CustomRoundedButton({
    super.key,
    required this.deviceInfo,
    required this.label,
    required this.backgroundColor,
    required this.onPressed,
    required this.textColor,
    this.assetIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: deviceInfo.screenHeight * 0.01),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(backgroundColor),
          fixedSize: WidgetStateProperty.all(
            Size(deviceInfo.screenWidth, deviceInfo.screenHeight * 0.055),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (assetIcon != null) ...[
              Image.asset(
                assetIcon!,
                width: deviceInfo.screenHeight * 0.035,
                height: deviceInfo.screenHeight * 0.035,
              ),
              SizedBox(width: deviceInfo.screenWidth * 0.015),
            ],
            Text(
              label,
              style: TextStyles.mediumWhite16.copyWith(
                  color: textColor, fontSize: deviceInfo.screenWidth * 0.03),
            ),
          ],
        ),
      ),
    );
  }
}
