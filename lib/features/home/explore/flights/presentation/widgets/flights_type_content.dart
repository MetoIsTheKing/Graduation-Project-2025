import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flights_utils.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flights_date_picker.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flights_field.dart';

class FlightsTypeContent extends StatelessWidget {
  const FlightsTypeContent({
    super.key,
    required this.fromController,
    required this.toController,
    required this.travellersController,
    required this.selectedDate,
    required this.onDepartureDateSelected,
    this.isTwoWay = false,
    this.returnDate,
    required this.onReturnDateSelected,
    this.onChangeButtonPressed,
    required this.onSearchFlightsPressed,
    required this.onTravellersFieldTapped,
    required this.onToFieldTapped,
    required this.onFromFieldTaped,
    this.ismultiCity = false,
  });
  final TextEditingController fromController;
  final TextEditingController toController;
  final TextEditingController travellersController;
  final DateTime? selectedDate;
  final DateTime? returnDate;
  final Function(DateTime) onDepartureDateSelected;
  final Function(DateTime) onReturnDateSelected;
  final bool? isTwoWay;
  final bool? ismultiCity;
  final Function()? onChangeButtonPressed;
  final void Function() onSearchFlightsPressed;
  final void Function() onTravellersFieldTapped;
  final void Function() onToFieldTapped;
  final void Function() onFromFieldTaped;

  @override
  Widget build(BuildContext context) {
    final deviceInfo = getIt<DeviceInfo>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'From',
          style: FlightsUtils.fieldLabelStyle,
        ),
        SizedBox(
          height: deviceInfo.screenHeight * 0.01,
        ),
        FlightsField(
          controller: fromController,
          prefixIcon: 'assets/images/flight_from.png',
          label: 'select start location',
          onTap: onFromFieldTaped,
        ),
        SizedBox(
          height: deviceInfo.screenHeight * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'To',
              style: FlightsUtils.fieldLabelStyle,
            ),
            IconButton(
              onPressed: onChangeButtonPressed,
              icon: Image.asset(
                'assets/images/flights_change.png',
              ),
            ),
          ],
        ),
        SizedBox(
          height: deviceInfo.screenHeight * 0.005,
        ),
        FlightsField(
          controller: toController,
          prefixIcon: 'assets/images/flight_to.png',
          label: 'select destination',
          onTap: onToFieldTapped,
        ),
        SizedBox(
          height: deviceInfo.screenHeight * 0.03,
        ),
        Text(
          'Departure Date',
          style: FlightsUtils.fieldLabelStyle,
        ),
        SizedBox(
          height: deviceInfo.screenHeight * 0.01,
        ),
        FlightsDatePickerField(
          deviceInfo: deviceInfo,
          hint: 'select departure date',
          prefixIcon: 'assets/images/flights_calender.png',
          selectedDate: selectedDate,
          onDateSelected: onDepartureDateSelected,
        ),
        SizedBox(
          height: deviceInfo.screenHeight * 0.03,
        ),
        isTwoWay! ? additionalReturnDate() : SizedBox(),
        Text(
          'Travelers',
          style: FlightsUtils.fieldLabelStyle,
        ),
        SizedBox(
          height: deviceInfo.screenHeight * 0.01,
        ),
        FlightsField(
          controller: travellersController,
          prefixIcon: 'assets/images/flights_traveller.png',
          label: 'select travellers',
          onTap: onTravellersFieldTapped,
        ),
      ],
    );
  }

  Widget additionalReturnDate() {
    final deviceInfo = getIt<DeviceInfo>();

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Return Date (optional)',
        style: FlightsUtils.fieldLabelStyle,
      ),
      SizedBox(
        height: deviceInfo.screenHeight * 0.01,
      ),
      FlightsDatePickerField(
        deviceInfo: deviceInfo,
        hint: 'select return date (optional)',
        prefixIcon: 'assets/images/flights_calender.png',
        selectedDate: returnDate,
        onDateSelected: onReturnDateSelected,
      ),
      SizedBox(
        height: deviceInfo.screenHeight * 0.03,
      ),
    ]);
  }
}
