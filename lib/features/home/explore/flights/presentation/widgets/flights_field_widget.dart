import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

class FlightsFieldWidget extends StatelessWidget {
  final DeviceInfo deviceInfo;
  final TextEditingController? controller;
  final String prefixIcon;
  final String label;
  final Function()? onTap;

  const FlightsFieldWidget({
    super.key,
    required this.controller,
    required this.prefixIcon,
    required this.label,
    this.onTap,
    required this.deviceInfo,
  });

  @override
  Widget build(BuildContext context) {
    //final deviceInfo = getIt<DeviceInfo>();
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextFormField(
            style: TextStyles.mediumDark16.copyWith(
                fontSize: deviceInfo.screenWidth * 0.03,
                color: Colors.black), // Replace this line
            controller: controller,
            readOnly: true, // Ensures user can't type
            decoration: InputDecoration(
              hintStyle: TextStyles.mediumDark16.copyWith(
                  fontSize: deviceInfo.screenWidth * 0.03,
                  color: Colors.grey), // Replace this line
              filled: true,
              fillColor: AppColors.appLighterGrey,
              hintText: label,
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  deviceInfo.screenHeight * 0.02, // Replace this line
                ),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: deviceInfo.screenWidth * 0.01,
                  vertical: deviceInfo.screenHeight * 0.001,
                ),
                child: Image.asset(
                  prefixIcon,
                  fit: BoxFit.scaleDown,
                  scale: deviceInfo.screenWidth * 0.002,
                ),
              ),
            )),
      ),
    );
  }
}
