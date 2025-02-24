import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';

class CustomSignupButton extends CustomRoundedButton {
  final String? assetIcon; // Optional icon

  CustomSignupButton({
    required super.deviceInfo,
    required super.label,
    required super.backgroundColor,
    required super.onPressed,
    required super.textColor,
    this.assetIcon, // Optional
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
              style: TextStyles.mediumWhite16.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
