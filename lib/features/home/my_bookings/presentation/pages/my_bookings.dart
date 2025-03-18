import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/base_widget.dart';
import 'package:graduation_project_2025/core/shared_components/empty_list_widget.dart';
import 'package:graduation_project_2025/core/shared_components/map_widget.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/ticket_tile.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MyBookings extends StatelessWidget {
  final ScrollController scrollController;
  const MyBookings({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> selected = ValueNotifier<int>(0);

    return InfoWidget(builder: (context, deviceInfo, constraints) {
      // placeholders-------------------------
      double scaleFactor =
          deviceInfo.deviceType == DeviceType.tablet ? 0.9 : 1.0;
      List<Widget> flights = [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.appBlue, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Transform.scale(
            scale: scaleFactor,
            child: TicketTile(
              isRecommended: true,
              scaleFactor: scaleFactor,
              originAirport: 'LGA',
              destinationAirport: 'DAD',
              stopsNumber: 0,
              departureTime: '10:00 AM',
              arrivalTime: '12:00 PM',
              price: '4000',
              airlineName: 'Qatar Airways',
              airlineLogo: 'assets/images/airline_logo.png',
              originCity: 'New York',
              destinationCity: 'Da Nang',
              departureDate: 'August 38, 2023',
              arrivalDate: 'August 38, 2023',
              flightDuration: '2h 30m',
              baggageAvailability: 'has more baggage options',
              tagData: 'Best Price',
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.appBlue, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Transform.scale(
            scale: scaleFactor,
            child: TicketTile(
              isRecommended: true,
              scaleFactor: scaleFactor,
              originAirport: 'LGA',
              destinationAirport: 'DAD',
              stopsNumber: 0,
              departureTime: '10:00 AM',
              arrivalTime: '12:00 PM',
              price: '4000',
              airlineName: 'Qatar Airways',
              airlineLogo: 'assets/images/airline_logo.png',
              originCity: 'New York',
              destinationCity: 'Da Nang',
              departureDate: 'August 38, 2023',
              arrivalDate: 'August 38, 2023',
              flightDuration: '2h 30m',
              baggageAvailability: 'has more baggage options',
              tagData: 'Best Price',
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.appBlue, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Transform.scale(
            scale: scaleFactor,
            child: TicketTile(
              isRecommended: true,
              scaleFactor: scaleFactor,
              originAirport: 'LGA',
              destinationAirport: 'DAD',
              stopsNumber: 0,
              departureTime: '10:00 AM',
              arrivalTime: '12:00 PM',
              price: '4000',
              airlineName: 'Qatar Airways',
              airlineLogo: 'assets/images/airline_logo.png',
              originCity: 'New York',
              destinationCity: 'Da Nang',
              departureDate: 'August 38, 2023',
              arrivalDate: 'August 38, 2023',
              flightDuration: '2h 30m',
              baggageAvailability: 'has more baggage options',
              tagData: 'Best Price',
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.appBlue, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Transform.scale(
            scale: scaleFactor,
            child: TicketTile(
              isRecommended: true,
              scaleFactor: scaleFactor,
              originAirport: 'LGA',
              destinationAirport: 'DAD',
              stopsNumber: 0,
              departureTime: '10:00 AM',
              arrivalTime: '12:00 PM',
              price: '4000',
              airlineName: 'Qatar Airways',
              airlineLogo: 'assets/images/airline_logo.png',
              originCity: 'New York',
              destinationCity: 'Da Nang',
              departureDate: 'August 38, 2023',
              arrivalDate: 'August 38, 2023',
              flightDuration: '2h 30m',
              baggageAvailability: 'has more baggage options',
              tagData: 'Best Price',
            ),
          ),
        ),
      ];
      return BaseWidget(
        scrollController: scrollController,
        backgroundWidget: MapWidget(
          imageHeight: deviceInfo.screenHeight * 0.3,
          topPadding: deviceInfo.screenHeight * 0.02,
        ),
        foregroundWidget: Padding(
          padding: EdgeInsets.only(top: deviceInfo.screenHeight * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bookings',
                style: TextStyles.bold24(deviceInfo, Colors.white),
              ),
              // switcher
              Container(
                height: deviceInfo.screenHeight * 0.05,
                constraints: BoxConstraints(
                  maxHeight: deviceInfo.screenHeight * 0.052,
                ),
                margin: EdgeInsets.symmetric(
                    horizontal: deviceInfo.screenWidth * 0.14,
                    vertical: deviceInfo.screenHeight * 0.02),
                padding: EdgeInsets.symmetric(
                    horizontal: deviceInfo.screenWidth * 0.015,
                    vertical: deviceInfo.screenWidth * 0.015),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    deviceInfo.screenWidth * 0.3,
                  ),
                ),
                child: ToggleSwitch(
                  animate: true,
                  curve: Curves.easeOut,
                  animationDuration: 200,
                  minWidth: deviceInfo.screenWidth * 0.4,
                  cornerRadius: 20.0,
                  activeBgColors: [
                    [AppColors.appYellow],
                    [AppColors.appYellow],
                  ],
                  inactiveBgColor: Colors.white,
                  inactiveFgColor: Colors.white,
                  initialLabelIndex: 0,
                  totalSwitches: 2,
                  labels: ['Flights', 'Hotels'],
                  radiusStyle: true,
                  customTextStyles: [
                    TextStyles.medium12(deviceInfo, AppColors.appDarkBlue),
                    TextStyles.medium12(deviceInfo, AppColors.appDarkBlue),
                  ],
                  onToggle: (index) {
                    selected.value = index!;
                    print('switched to: $index');
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: deviceInfo.screenWidth * 0.04,
                    vertical: deviceInfo.screenHeight * 0.02),
                width: double.infinity,
                constraints: BoxConstraints(
                  minHeight: deviceInfo.screenHeight * 0.8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(deviceInfo.screenWidth * 0.08),
                    topRight: Radius.circular(deviceInfo.screenWidth * 0.08),
                  ),
                ),
                child: ValueListenableBuilder<int>(
                    valueListenable: selected,
                    builder: (context, value, child) {
                      if (selected.value == 0) {
                        if (flights.isNotEmpty) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            clipBehavior: Clip.antiAlias,
                            itemCount: flights.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: deviceInfo.screenWidth * 0.02,
                                    vertical: deviceInfo.screenHeight * 0.01),
                                child: flights[index].animate().fadeIn(),
                              );
                            },
                          );
                        } else {
                          return EmptyListWidget(
                            deviceInfo: deviceInfo,
                            selected: selected.value,
                            sectionName:
                                selected.value == 0 ? 'flights' : 'hotels',
                          ).animate().shakeX();
                        }
                      } else {
                        return EmptyListWidget(
                          deviceInfo: deviceInfo,
                          selected: selected.value,
                          sectionName:
                              selected.value == 0 ? 'flights' : 'hotels',
                        ).animate().shakeX();
                      }
                    }),
              ),
            ],
          ),
        ),
      );
    });
  }
}
