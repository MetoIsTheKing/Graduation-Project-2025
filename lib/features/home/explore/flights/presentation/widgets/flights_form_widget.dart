import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

import 'package:graduation_project_2025/features/home/explore/flights/presentation/flight_actions_model.dart';

import 'package:graduation_project_2025/features/home/explore/flights/presentation/flight_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flights_utils.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flights_field_widget.dart';

class FlightsFormWidget extends StatelessWidget {
  const FlightsFormWidget({
    super.key,
    required this.flightModel,
    required this.flightActionsModel,
    this.isTwoWay = false,
    this.buttonPressed = false,
    this.isMultiCity = false,
  });

  final FlightModel flightModel;
  final FlightActionsModel flightActionsModel;
  final bool isTwoWay;
  final bool buttonPressed;
  final bool isMultiCity;

  @override
  Widget build(BuildContext context) {
    final deviceInfo = getIt<DeviceInfo>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'From',
          style: TextStyles.semiBold18(deviceInfo, AppColors.appBlack).copyWith(
              fontSize: deviceInfo.screenWidth * 0.03), // Replace this line
        ),
        SizedBox(
          height: deviceInfo.screenHeight * 0.01,
        ),
        FlightsFieldWidget(
          controller: flightModel.fromController,
          prefixIcon: 'assets/images/flight_from.png',
          label: 'select start location',
          onTap: () {
            flightActionsModel.onFromFieldTaped(flightModel);
          },
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: deviceInfo.screenHeight * 0.01),
              child: Text(
                'To',
                style: TextStyles.semiBold18(deviceInfo, AppColors.appBlack)
                    .copyWith(
                        fontSize:
                            deviceInfo.screenWidth * 0.03), // Replace this line
              ),
            ),
            FittedBox(
              child: IconButton(
                onPressed: () {
                  flightActionsModel.onChangePressed(flightModel);
                },
                icon: Image.asset(
                  'assets/images/flights_change.png',
                  width: deviceInfo.screenWidth * 0.04,
                  height: deviceInfo.screenHeight * 0.04,
                ),
              ),
            ),
          ],
        ),
        // SizedBox(
        //   height: deviceInfo.screenHeight * 0.005,
        // ),
        FlightsFieldWidget(
          controller: flightModel.toController,
          prefixIcon: 'assets/images/flight_to.png',
          label: 'select destination',
          onTap: () {
            flightActionsModel.onToFieldTapped(flightModel);
          },
        ),
        SizedBox(
          height: deviceInfo.screenHeight * 0.03,
        ),
        Text(
          'Select Date',
          style: TextStyles.semiBold18(deviceInfo, AppColors.appBlack).copyWith(
              fontSize: deviceInfo.screenWidth * 0.03), // Replace this line
        ),
        SizedBox(
          height: deviceInfo.screenHeight * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: deviceInfo.screenWidth * 0.02),
                child: FlightsFieldWidget(
                  controller: flightModel.departureDateController,
                  prefixIcon: 'assets/images/flights_calender.png',
                  label: 'select departure date',
                  onTap: () {
                    flightActionsModel.onDatePickerTapped(
                        selecteFlightModel: flightModel);
                  },
                ),
              ),
            ),
            isTwoWay
                ? Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: deviceInfo.screenWidth * 0.02),
                      child: FlightsFieldWidget(
                        controller: flightModel.returnDateController,
                        prefixIcon: 'assets/images/flights_calender.png',
                        label: 'select return date',
                        onTap: () {
                          flightActionsModel.onDatePickerTapped(
                              selecteFlightModel: flightModel,
                              isReturnDate: true);
                        },
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),

        SizedBox(
          height: deviceInfo.screenHeight * 0.03,
        ),
        Text(
          'Travelers',
          style: TextStyles.semiBold18(deviceInfo, AppColors.appBlack).copyWith(
              fontSize: deviceInfo.screenWidth * 0.03), // Replace this line
        ),
        SizedBox(
          height: deviceInfo.screenHeight * 0.01,
        ),

        FlightsFieldWidget(
          controller: flightModel.travellersController,
          prefixIcon: 'assets/images/flights_traveller.png',
          label: 'select travellers',
          onTap: () {
            flightActionsModel.onTravellersFieldTapped(flightModel);
          },
        ),
        SizedBox(
          height: deviceInfo.screenHeight * 0.03,
        ),
        isMultiCity
            ? SizedBox()
            : CustomRoundedButton(
                deviceInfo: deviceInfo,
                label: 'Search Flights',
                backgroundColor: AppColors.appBlue,
                onPressed: () {
                  flightActionsModel.onSearchFlightsPressed(flightModel);
                },
                textColor: Colors.white,
              ),
      ],
    );
  }
}
