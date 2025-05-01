import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/models/flight_result_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/flights_data_cubit.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/search_flights/search_flights_cubit.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/curved_appbar.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/ticket_tile.dart';

class FlightSearchResultsScreen extends StatelessWidget {
  final SearchFlightsCubit searchFlightsCubit;
  final Map<String, dynamic> searchQuery;
  const FlightSearchResultsScreen(
      {super.key, required this.searchFlightsCubit,required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: searchFlightsCubit,
      child: InfoWidget(
        builder: (context, deviceInfo, constraints) {
          double scaleFactor =
              deviceInfo.deviceType == DeviceType.tablet ? 0.9 : 1.0;
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.appBlue,
            appBar: CurvedAppbar(
              actions: [
                Padding(
                  padding:
                      EdgeInsets.only(right: deviceInfo.screenWidth * 0.02),
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
                          searchQuery?["originLocationCode"] ?? 'error',
                          style: TextStyles.medium20(
                              deviceInfo, AppColors.appDarkBlue),
                        ),
                        Text(
                          '-> ',
                          style: TextStyles.medium20(
                              deviceInfo, AppColors.appYellow),
                        ),
                        Text(
                          searchQuery?["destinationLocationCode"] ?? 'error',
                          style: TextStyles.medium20(
                              deviceInfo, AppColors.appDarkBlue),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${searchQuery?["departureDate"]}',
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
                            // Transform.scale(
                            //   scale: scaleFactor,
                            //   child: TicketTile(
                            //     flight: FlightResultModel(
                            //         ),
                            //     arrivalAirportName: '',
                            //     departureAirportName: '',
                            //     isRecommended: true,
                            //     scaleFactor: scaleFactor,
                            //     baggageAvailability: 'has more baggage options',
                            //     tagData: 'Best Price',
                            //   ),
                            // ),
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
      ),
    );
  }
}
