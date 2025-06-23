import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/search_flights/flights_field_widget.dart';

class FlightsFormWidget extends StatelessWidget {
  final DeviceInfo deviceInfo;
  final TextEditingController fromController;
  final TextEditingController toController;
  final TextEditingController departureDateController;
  final TextEditingController returnDateController;
  final TextEditingController travellersController;
  final bool isRoundTrip;
  final bool isNonStop;
  final DateTime? departureDate;
  final DateTime? returnDate;

  // Functions passed through constructor
  final VoidCallback onFromFieldTapped;
  final VoidCallback onToFieldTapped;
  final VoidCallback onChangePressed;
  final void Function({bool isReturnDate}) onDatePickerTapped;
  final VoidCallback onTravellersFieldTapped;
  final VoidCallback onSearchFlightsPressed;
  final void Function(bool)? onNonStopChanged;

  const FlightsFormWidget({
    super.key,
    this.isRoundTrip = false,
    required this.deviceInfo,
    required this.fromController,
    required this.toController,
    required this.departureDateController,
    required this.returnDateController,
    required this.travellersController,
    required this.onFromFieldTapped,
    required this.onToFieldTapped,
    required this.onChangePressed,
    required this.onNonStopChanged,
    required this.onDatePickerTapped,
    required this.onTravellersFieldTapped,
    required this.onSearchFlightsPressed,
    required this.departureDate,
    required this.returnDate,
    required this.isNonStop,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.centerRight,
          children: [
            Column(
              children: [
                FlightsFieldWidget(
                  formWidgetLabel: 'From',
                  isTravellers: false,
                  deviceInfo: deviceInfo,
                  controller: fromController,
                  prefixIcon: 'assets/images/flight_from.png',
                  label: 'select start location',
                  validateField: (value) {
                    if (value == null || value.isEmpty) {
                      return 'select an origin airport';
                    }
                    return null;
                  },
                  onTap: onFromFieldTapped,
                ),
                FlightsFieldWidget(
                  formWidgetLabel: 'To',
                  isTravellers: false,
                  deviceInfo: deviceInfo,
                  controller: toController,
                  prefixIcon: 'assets/images/flight_to.png',
                  label: 'select destination',
                  onTap: onToFieldTapped,
                  validateField: (value) {
                    if (value == null || value.isEmpty) {
                      return 'select a destination airport';
                    }
                    return null;
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: deviceInfo.screenHeight * 0.02),
              child: IconButton(
                onPressed: onChangePressed,
                icon: Image.asset(
                  'assets/images/flights_change.png',
                  width: deviceInfo.screenWidth * 0.06,
                  height: deviceInfo.screenHeight * 0.03,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: FlightsFieldWidget(
                formWidgetLabel: 'Departure Date',
                isTravellers: false,
                deviceInfo: deviceInfo,
                controller: departureDateController,
                prefixIcon: 'assets/images/flights_calender.png',
                label: 'select a date',
                onTap: () => onDatePickerTapped(isReturnDate: false),
                validateField: (value) {
                  if (value == null || value.isEmpty) {
                    return 'select departure date';
                  }
                  return null;
                },
              ),
            ),
            Visibility(
              visible: isRoundTrip,
              child: Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: deviceInfo.screenWidth * 0.02),
                  child: FlightsFieldWidget(
                    formWidgetLabel: 'Return Date',
                    isTravellers: false,
                    deviceInfo: deviceInfo,
                    controller: returnDateController,
                    prefixIcon: 'assets/images/flights_calender.png',
                    label: 'select a date',
                    onTap: () => onDatePickerTapped(isReturnDate: true),
                    validateField: (value) {
                      if (value == null || value.isEmpty) {
                        return 'select return date';
                      } else if (departureDate != null && returnDate != null) {
                        final departureOnly = DateTime(
                          departureDate!.year,
                          departureDate!.month,
                          departureDate!.day,
                        );
                        final returnOnly = DateTime(
                          returnDate!.year,
                          returnDate!.month,
                          returnDate!.day,
                        );

                        if (returnOnly.isBefore(departureOnly) ||
                            returnOnly.isAtSameMomentAs(departureOnly)) {
                          return 'wrong range';
                        }
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          spacing: deviceInfo.screenWidth * 0.04,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: deviceInfo.screenWidth * 0.65,
              child: FlightsFieldWidget(
                formWidgetLabel: 'Travellers',
                isTravellers: true,
                deviceInfo: deviceInfo,
                controller: travellersController,
                prefixIcon: 'assets/images/flights_traveller.png',
                label: 'select travellers',
                onTap: onTravellersFieldTapped,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(bottom: deviceInfo.screenHeight * 0.01),
                  child: Text('Trip Stops',
                      style: TextStyles.semiBold18(
                              deviceInfo, AppColors.appBlack)
                          .copyWith(fontSize: deviceInfo.screenWidth * 0.03)),
                ),
                Switch(
                  value: isNonStop,
                  activeTrackColor: AppColors.appBlue,
                  inactiveTrackColor: AppColors.appGrey,
                  onChanged: (value) => onNonStopChanged!(value),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: deviceInfo.screenHeight * 0.01,
        ),
        CustomRoundedButton(
          deviceInfo: deviceInfo,
          label: 'Search Flights',
          backgroundColor: AppColors.appBlue,
          onPressed: onSearchFlightsPressed,
          textColor: Colors.white,
        ),
      ],
    );
  }
}
