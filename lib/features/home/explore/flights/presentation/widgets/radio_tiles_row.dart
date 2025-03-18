import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';

import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flights_utils.dart';

class RadioTilesRow extends StatelessWidget {
  final String? selectedFlightType;
  final void Function(String? value) onSelectedFlightType;

  const RadioTilesRow({
    super.key,
    required this.selectedFlightType,
    required this.onSelectedFlightType,
  });

  @override
  Widget build(BuildContext context) {
    final deviceInfo = getIt<DeviceInfo>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: RadioListTile(
            activeColor: AppColors.appBlue,
            value: 'option1',
            groupValue: selectedFlightType,
            onChanged: onSelectedFlightType,
            visualDensity: VisualDensity.compact, // Reduces space
            contentPadding: EdgeInsets.zero, // Removes extra padding
            title: Text('one-way',
                style: TextStyles.semiBold18(deviceInfo, AppColors.appBlack)
                    .copyWith(fontSize: deviceInfo.screenWidth * 0.03)),
          ),
        ),
        Expanded(
          child: RadioListTile(
            activeColor: AppColors.appBlue,
            value: 'option2',
            groupValue: selectedFlightType,
            onChanged: (String? value) {
              onSelectedFlightType(value);
            },
            visualDensity: VisualDensity.compact, // Reduces space
            contentPadding: EdgeInsets.zero, // Removes extra padding
            title: Text(
              'Round-trip',
              style: TextStyles.semiBold18(deviceInfo, AppColors.appBlack)
                  .copyWith(
                      fontSize:
                          deviceInfo.screenWidth * 0.03), // Replace this line
            ),
          ),
        ),
        Expanded(
          child: RadioListTile(
            activeColor: AppColors.appBlue,
            value: 'option3',
            groupValue: selectedFlightType,
            onChanged: (String? value) {
              onSelectedFlightType(value);
            },
            visualDensity: VisualDensity.compact, // Reduces space
            contentPadding: EdgeInsets.zero, // Removes extra padding
            title: Text('Multi-city',
                style: TextStyles.semiBold18(deviceInfo, AppColors.appBlack)
                    .copyWith(fontSize: deviceInfo.screenWidth * 0.03)),
          ),
        ),
      ],
    );
  }
}
