import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

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
    final options = [
      {'value': 'option1', 'label': 'One-way'},
      {'value': 'option2', 'label': 'Round-trip'},
      {'value': 'option3', 'label': 'Multi-city'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: options.map((option) {
        return Expanded(
          child: FlightTypeRadioTile(
            value: option['value']!,
            label: option['label']!,
            selectedValue: selectedFlightType,
            onChanged: onSelectedFlightType,
            deviceInfo: deviceInfo,
          ),
        );
      }).toList(),
    );
  }
}

class FlightTypeRadioTile extends StatelessWidget {
  final String value;
  final String label;
  final String? selectedValue;
  final void Function(String? value) onChanged;
  final DeviceInfo deviceInfo;

  const FlightTypeRadioTile({
    super.key,
    required this.value,
    required this.label,
    required this.selectedValue,
    required this.onChanged,
    required this.deviceInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        listTileTheme: const ListTileThemeData(horizontalTitleGap: 2),
      ),
      child: RadioListTile(
        activeColor: AppColors.appBlue,
        value: value,
        groupValue: selectedValue,
        onChanged: onChanged,
        visualDensity: VisualDensity.compact,
        contentPadding: EdgeInsets.zero,
        title: Text(
          label,
          style: TextStyles.semiBold18(deviceInfo, AppColors.appBlack)
              .copyWith(fontSize: deviceInfo.screenWidth * 0.03),
        ),
      ),
    );
  }
}
