import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flights_utils.dart';

class FlightsFieldWidget extends StatelessWidget {
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
  });

  @override
  Widget build(BuildContext context) {
    final deviceInfo = getIt<DeviceInfo>();
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        // Prevents keyboard from showing up
        child: TextFormField(
            style: FlightsUtils.fieldInputStyle,
            controller: controller,
            readOnly: true, // Ensures user can't type
            decoration: InputDecoration(
              hintStyle: FlightsUtils.hintTextStyle,
              filled: true,
              fillColor: AppColors.appLighterGrey,
              hintText: label,
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  FlightsUtils.fieldBorderRaduis,
                ),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: deviceInfo.screenWidth * 0.03,
                  vertical: deviceInfo.screenHeight * 0.01,
                ), // Adjust padding as needed
                child: Image.asset(
                  prefixIcon,
                  width: 24, // Adjust size if needed
                  height: 24,
                ),
              ),
            )),
      ),
    );
  }
}
