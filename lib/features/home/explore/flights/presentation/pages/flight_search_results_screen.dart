import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/routing/arguments.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/search_flights/search_flights_cubit.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/curved_appbar.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/ticket_tile.dart';

import '../../data/models/flight_result_model.dart';
import 'flight_review_screen.dart';

class FlightSearchResultsScreen extends StatelessWidget {
  final SearchFlightsCubit searchFlightsCubit;
  final Map<String, dynamic> searchQuery;
  const FlightSearchResultsScreen(
      {super.key, required this.searchFlightsCubit, required this.searchQuery});

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
                          searchQuery["originLocationCode"] ?? 'error',
                          style: TextStyles.medium20(
                              deviceInfo, AppColors.appDarkBlue),
                        ),
                        Text(
                          '-> ',
                          style: TextStyles.medium20(
                              deviceInfo, AppColors.appYellow),
                        ),
                        Text(
                          searchQuery["destinationLocationCode"] ?? 'error',
                          style: TextStyles.medium20(
                              deviceInfo, AppColors.appDarkBlue),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${searchQuery["departureDate"]}',
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
                        child:
                            BlocBuilder<SearchFlightsCubit, SearchFlightsState>(
                          builder: (context, state) {
                            if (state is FlightsIsLoading) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    top: deviceInfo.screenHeight * 0.4),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.appYellow,
                                    strokeWidth: deviceInfo.screenWidth * 0.01,
                                  ),
                                ),
                              );
                            } else if (state is FlightsLoaded &&
                                state.flights.isEmpty) {
                              return Center(
                                child: Text(
                                  'No flights found',
                                  style: TextStyles.medium20(
                                      deviceInfo, Colors.white),
                                ),
                              );
                            } else if (state is FlightsOnNetworkError) {
                              return Center(
                                child: Text(
                                  state.errorMessage,
                                  style: TextStyles.medium20(
                                      deviceInfo, Colors.white),
                                ),
                              );
                            } else if (state is FlightsOnError) {
                              return Center(
                                child: Text(
                                  state.errorMessage,
                                  style: TextStyles.medium20(
                                      deviceInfo, Colors.white),
                                ),
                              );
                            } else if (state is FlightsLoaded) {
                              final flightsResults = state.flights;

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListView.builder(
                                    itemCount: flightsResults.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      //log('list of Carrier codes : ${getAirlineName(flightsResults[index].itineraries[0].segments[0].carrierCode).toString()}');

                                      return Transform.scale(
                                        scale: scaleFactor,
                                        child: TicketTile(
                                          onTap: (FlightResultModel flight) {
                                            log('flightTicketTapped');
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FlightReviewScreen(
                                                        flight: flight),
                                              ),
                                            );
                                          },
                                          flight: flightsResults[index],
                                          arrivalAirportName:
                                              getIt<AirportsDetails>()
                                                          .arrAirportsDetails?[
                                                      'airportName'] ??
                                                  'error',
                                          departureAirportName:
                                              getIt<AirportsDetails>()
                                                          .depAirportsDetails?[
                                                      'airportName'] ??
                                                  'error',
                                          isRecommended: true,
                                          scaleFactor: scaleFactor,
                                          baggageAvailability:
                                              'has more baggage options',
                                          tagData: 'Best Price',
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            } else {
                              return Center(
                                child: Text(
                                  'something went wrong',
                                  style: TextStyles.medium20(
                                      deviceInfo, Colors.white),
                                ),
                              );
                            }
                          },
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
