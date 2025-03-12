import 'package:flutter/material.dart';

import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_app_bar.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flights_utils.dart';

class RadioTilesRow extends StatelessWidget {
  final String? selectedFlightType;
  final void Function(String? value) onSelectedFlightType;
  const RadioTilesRow(
      {super.key,
      required this.selectedFlightType,
      required this.onSelectedFlightType});

  @override
  Widget build(BuildContext context) {
    //final deviceInfo = getIt<DeviceInfo>();

    return Row(
      children: [
        Expanded(
          child: RadioListTile(
              activeColor: AppColors.appBlue,
              value: 'option1',
              groupValue: selectedFlightType,
              onChanged: onSelectedFlightType),
        ),
        SizedBox(
          width: deviceInfo.screenWidth * 0.05,
        ),
        Text('one-way', style: FlightsUtils.radiotileTextStyle),
        Expanded(
          child: RadioListTile(
            activeColor: AppColors.appBlue,
            value: 'option2',
            groupValue: selectedFlightType,
            onChanged: (String? value) {
              onSelectedFlightType(value);
            },
          ),
        ),
        SizedBox(
          width: deviceInfo.screenWidth * 0.05,
        ),
        Text(
          'Round-trip',
          style: FlightsUtils.radiotileTextStyle,
        ),
        Expanded(
          child: RadioListTile(
            activeColor: AppColors.appBlue,
            value: 'option3',
            groupValue: selectedFlightType,
            onChanged: (String? value) {
              onSelectedFlightType(value);
            },
          ),
        ),
        SizedBox(
          width: deviceInfo.screenWidth * 0.05,
        ),
        Text('Multi-city', style: FlightsUtils.radiotileTextStyle),
      ],
    );
  }
}
