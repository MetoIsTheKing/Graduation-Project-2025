import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flights_utils.dart';

class FlightsField extends StatelessWidget {
  final TextEditingController? controller;
  final String prefixIcon;
  final String label;
  const FlightsField({
    super.key,
    required this.controller,
    required this.prefixIcon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final deviceInfo = getIt<DeviceInfo>();
    return GestureDetector(
      onTap: () {
        print("TextField tapped!");
        // You can add custom actions here
      },
      child: AbsorbPointer(
        // Prevents keyboard from showing up
        child: TextFormField(
            controller: controller,
            readOnly: true, // Ensures user can't type
            decoration: InputDecoration(
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
