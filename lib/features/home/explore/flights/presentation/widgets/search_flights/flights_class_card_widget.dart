import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

class FlightsClassCardWidget extends StatelessWidget {
  final String flightClass;
  final void Function(String? selectedValue) onSelectedFlightClass;
  const FlightsClassCardWidget({
    super.key,
    required this.onSelectedFlightClass, required this.flightClass,
  });

  @override
  Widget build(BuildContext context) {
    final deviceInfo = getIt<DeviceInfo>();
    final List<Map<String, String>> flightClasses = [
      {'label': 'Economy', 'value': 'ECONOMY'},
      {'label': 'Premium Economy', 'value': 'PREMIUM_ECONOMY'},
      {'label': 'Business', 'value': 'BUSINESS'},
      {'label': 'First', 'value': 'FIRST'},
    ];

    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(deviceInfo.screenHeight * 0.02),
          ),
          color: Colors.white,
          elevation: 5,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(deviceInfo.screenHeight * 0.02),
                    topRight: Radius.circular(deviceInfo.screenHeight * 0.02),
                  ),
                  color: AppColors.appBlue,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: deviceInfo.screenWidth * 0.03,
                  vertical: deviceInfo.screenHeight * 0.015,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: deviceInfo.screenWidth * 0.01),
                      child: Image.asset(
                        'assets/images/travellers_class_icon.png',
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Cabin Class',
                      style: TextStyles.regular16(deviceInfo, Colors.white)
                          .copyWith(fontSize: deviceInfo.screenWidth * 0.03),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: deviceInfo.screenWidth * 0.03,
                  vertical: deviceInfo.screenHeight * 0.02,
                ),
                child: Column(
                  children: flightClasses.map((classItem) {
                    return RadioListTile<String>(
                      value: classItem['value']!,
                      groupValue: flightClass,
                      onChanged: onSelectedFlightClass,
                      activeColor: AppColors.appBlue,
                      title: Text(classItem['label']!),
                      visualDensity: VisualDensity.compact, // Reduces space
                      contentPadding: EdgeInsets.zero, // Removes extra padding
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(),
      ],
    );
  }
}
