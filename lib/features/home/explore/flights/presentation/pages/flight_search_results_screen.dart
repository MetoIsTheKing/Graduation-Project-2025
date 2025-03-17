import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/curved_appbar.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/ticket_tile.dart';

class FlightSearchResultsScreen extends StatelessWidget {
  const FlightSearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context, deviceInfo, constraints) {
        double scaleFactor =
            deviceInfo.deviceType == DeviceType.tablet ? 0.9 : 1.0;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.appBlue,
          appBar: CurvedAppbar(
            actions: [
              Padding(
                padding: EdgeInsets.only(right: deviceInfo.screenWidth * 0.02),
                child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/images/currency_icon.svg',
                      height: deviceInfo.screenHeight * 0.03,
                    )),
              ),
            ],
            backgroundColor: Colors.white,
            backButtonColor: AppColors.appBlue,
            onBack: () => context.pop(),
            titleWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IntrinsicWidth(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'LGA ',
                        style: TextStyles.medium20(
                            deviceInfo, AppColors.appDarkBlue),
                      ),
                      Text(
                        '-> ',
                        style: TextStyles.medium20(
                            deviceInfo, AppColors.appYellow),
                      ),
                      Text(
                        'DAD',
                        style: TextStyles.medium20(
                            deviceInfo, AppColors.appDarkBlue),
                      ),
                    ],
                  ),
                ),
                Text(
                  '2 travellers - One way - 20 Feb',
                  style:
                      TextStyles.regular14(deviceInfo, AppColors.appDarkBlue),
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.appBlue,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: deviceInfo.screenHeight * 0.1),
                      child: Image.asset(
                        'assets/images/global_map.png',
                        height: deviceInfo.screenHeight * 0.5,
                        width: deviceInfo.screenWidth,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceInfo.screenWidth * 0.05,
                        vertical: deviceInfo.screenHeight * 0.01),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.scale(
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
                          Transform.scale(
                            scale: scaleFactor,
                            child: TicketTile(
                              isRecommended: false,
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
