import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flight_actions_model.dart';

import 'package:graduation_project_2025/features/home/explore/flights/presentation/flight_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flights_utils.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flights_date_picker_widget.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flights_field_widget.dart';

class FlightsFormWidget extends StatelessWidget {
  const FlightsFormWidget({
    super.key,
    required this.flightModel,
    required this.flightActionsModel,
    this.isTwoWay = false,
    this.buttonPressed = false,
  });

  final FlightModel flightModel;
  final FlightActionsModel flightActionsModel;
  final bool isTwoWay;
  final bool buttonPressed;

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
        FlightsFieldWidget(
          controller: flightModel.fromController,
          prefixIcon: 'assets/images/flight_from.png',
          label: 'select start location',
          onTap: flightActionsModel.onFromFieldTaped,
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
              onPressed: () => flightActionsModel.onChangePressed(),
              icon: Image.asset(
                'assets/images/flights_change.png',
              ),
            ),
          ],
        ),
        SizedBox(
          height: deviceInfo.screenHeight * 0.005,
        ),
        FlightsFieldWidget(
          controller: flightModel.toController,
          prefixIcon: 'assets/images/flight_to.png',
          label: 'select destination',
          onTap: flightActionsModel.onToFieldTapped,
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
        FlightsDatePickerWidget(
          deviceInfo: deviceInfo,
          hint: 'select date',
          prefixIcon: 'assets/images/flights_calender.png',
          departureDate: flightModel.departureDate,
          onDateSelected: flightActionsModel.onDepartureDateSelected,
        ),
        isTwoWay ? additionalReturnDate() : SizedBox(),
        SizedBox(
          height: deviceInfo.screenHeight * 0.03,
        ),
        Text(
          'Travelers',
          style: FlightsUtils.fieldLabelStyle,
        ),
        SizedBox(
          height: deviceInfo.screenHeight * 0.01,
        ),
        FlightsFieldWidget(
          controller: flightModel.travellersController,
          prefixIcon: 'assets/images/flights_traveller.png',
          label: 'select travellers',
          onTap: flightActionsModel.onTravellersFieldTapped,
        ),
      ],
    );
  }

  Widget additionalReturnDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: flightActionsModel.onAddReturnDateTapped,
                icon: Icon(
                  Icons.add,
                  color: AppColors.appBlue,
                )),
            Text(
              'add return date?',
              style: FlightsUtils.fieldLabelStyle,
            ),
          ],
        ),
      ],
    );
    //   } else {
    //     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //       Row(
    //         children: [
    //           IconButton(
    //               onPressed: () {},
    //               icon: Icon(
    //                 Icons.minimize,
    //                 color: Colors.red,
    //               )),
    //           Text(
    //             'Return Date',
    //             style: FlightsUtils.fieldLabelStyle,
    //           ),
    //         ],
    //       ),
    //       SizedBox(
    //         height: deviceInfo.screenHeight * 0.01,
    //       ),
    //       FlightsDatePickerWidget(
    //         deviceInfo: deviceInfo,
    //         hint: 'select return date',
    //         prefixIcon: 'assets/images/flights_calender.png',
    //         selectedDate: flightModel.returnDate,
    //         onDateSelected: flightActionsModel.onReturnDateSelected,
    //       ),
    //       SizedBox(
    //         height: deviceInfo.screenHeight * 0.03,
    //       ),
    //     ]);
    //   }
    // }
  }
}
