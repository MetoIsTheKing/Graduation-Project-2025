import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/routing/auth_navigation_state.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/helpers/my_logger.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_functions/mapping_airports_codes.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduation_project_2025/features/booking/data/models/booking_sub_models.dart';
import 'package:graduation_project_2025/features/booking/data/models/one_way_booking_model.dart';
import 'package:graduation_project_2025/features/booking/presentaion/pages/booking_application_screen.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/search_flights/search_flights_cubit.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/models/flight_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/curved_appbar.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flight_search_results/ticket_tile.dart';

import '../../../../../booking/data/models/round_trip_booking_model.dart';
import '../../data/models/flight_result_model.dart';
import 'flight_details_screen.dart';

class FlightSearchResultsScreen extends StatefulWidget {
  final SearchFlightsCubit searchFlightsCubit;

  const FlightSearchResultsScreen(
      {super.key, required this.searchFlightsCubit});

  @override
  State<FlightSearchResultsScreen> createState() =>
      _FlightSearchResultsScreenState();
}

class _FlightSearchResultsScreenState extends State<FlightSearchResultsScreen> {
  @override
  void initState() {
    super.initState();
    if (getIt<FlightSearchQueryParams>().isRoundTrip) {
      if (getIt<FlightSearchQueryParams>().goOrReturnIndicator == 0) {
        widget.searchFlightsCubit
            .searchFlights(getIt<FlightSearchQueryParams>().toGoMap());
      } else {
        widget.searchFlightsCubit
            .searchFlights(getIt<FlightSearchQueryParams>().toReturnMap());
      }
    } else {
      widget.searchFlightsCubit
          .searchFlights(getIt<FlightSearchQueryParams>().toGoMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.searchFlightsCubit,
      child: InfoWidget(
        builder: (context, deviceInfo, constraints) {
          double scaleFactor =
              deviceInfo.deviceType == DeviceType.tablet ? 0.9 : 1.0;
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.appBlue,
            appBar: CurvedAppbar(
              backgroundColor: Colors.white,
              backButtonColor: AppColors.appBlue,
              onBack: () {
                if (getIt<FlightSearchQueryParams>().isRoundTrip) {
                  if (getIt<FlightSearchQueryParams>().goOrReturnIndicator ==
                      0) {
                    context.pop();
                  } else {
                    getIt<FlightSearchQueryParams>().goOrReturnIndicator = 0;
                    widget.searchFlightsCubit.toggleFlightList();
                    context.pop();
                  }
                } else {
                  context.pop();
                }
              },
              titleWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IntrinsicWidth(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          getIt<FlightSearchQueryParams>()
                                      .goOrReturnIndicator ==
                                  0
                              ? getIt<FlightSearchQueryParams>()
                                  .originLocationCode
                              : getIt<FlightSearchQueryParams>()
                                  .destinationLocationCode,
                          style: TextStyles.medium20(
                              deviceInfo, AppColors.appDarkBlue),
                        ),
                        Text(
                          '-> ',
                          style: TextStyles.medium20(
                              deviceInfo, AppColors.appYellow),
                        ),
                        Text(
                          getIt<FlightSearchQueryParams>()
                                      .goOrReturnIndicator ==
                                  0
                              ? getIt<FlightSearchQueryParams>()
                                  .destinationLocationCode
                              : getIt<FlightSearchQueryParams>()
                                  .originLocationCode,
                          style: TextStyles.medium20(
                              deviceInfo, AppColors.appDarkBlue),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    getIt<FlightSearchQueryParams>().goOrReturnIndicator == 0
                        ? getIt<FlightSearchQueryParams>()
                            .toGoMap()['departureDate']
                        : getIt<FlightSearchQueryParams>()
                            .toReturnMap()['departureDate'],
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
                          children: [
                            Visibility(
                                visible: getIt<FlightSearchQueryParams>()
                                    .isRoundTrip,
                                child: getIt<FlightSearchQueryParams>()
                                            .goOrReturnIndicator ==
                                        0
                                    ? Text(
                                        'Select departure flight',
                                        style: TextStyles.semiBold18(
                                            deviceInfo, Colors.white),
                                      )
                                    : Text(
                                        'Select return flight',
                                        style: TextStyles.semiBold18(
                                            deviceInfo, Colors.white),
                                      )),
                            BlocBuilder<SearchFlightsCubit, SearchFlightsState>(
                              builder: (context, state) {
                                if (state is FlightsIsLoading) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: deviceInfo.screenHeight * 0.4),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.appYellow,
                                        strokeWidth:
                                            deviceInfo.screenWidth * 0.01,
                                      ),
                                    ),
                                  );
                                } else if ((state is FlightsGoLoaded &&
                                        state.goFlights.isEmpty) ||
                                    (state is FlightsReturnLoaded &&
                                        state.returnFlights.isEmpty)) {
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
                                } else if (state is FlightsGoLoaded ||
                                    state is FlightsReturnLoaded) {
                                  // Determine the correct flights list based on the state
                                  final List<FlightResultModel> flightsResults =
                                      state is FlightsGoLoaded
                                          ? state.goFlights
                                          : state is FlightsReturnLoaded
                                              ? state.returnFlights
                                              : [];

                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ListView.builder(
                                        itemCount: flightsResults.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Transform.scale(
                                            scale: scaleFactor,
                                            child: TicketTile(
                                              onTap:
                                                  (FlightResultModel flight) {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) =>
                                                      FlightDetailsScreen(
                                                    flight: flight,
                                                    isEconomy:
                                                        getIt<FlightSearchQueryParams>()
                                                                .travelClass ==
                                                            'ECONOMY',
                                                    onContinuePressed:
                                                        (BaggageOptionModel
                                                                baggageOption,
                                                            double
                                                                totalPrice) async {
                                                      if (getIt<
                                                              FlightSearchQueryParams>()
                                                          .isRoundTrip) {
                                                        if (getIt<FlightSearchQueryParams>()
                                                                .goOrReturnIndicator ==
                                                            0) {
                                                          getIt<FlightSearchQueryParams>()
                                                              .incrementIndicator();
                                                          handleSignInAndBookingRoundTrip(
                                                              flight,
                                                              baggageOption,
                                                              totalPrice,
                                                              false);
                                                          context.pushNamed(Routes
                                                              .searchFlightResults);
                                                        } else {
                                                          handleSignInAndBookingRoundTrip(
                                                              flight,
                                                              baggageOption,
                                                              totalPrice,
                                                              true);
                                                        }
                                                      } else {
                                                        handleSignInAndBookingOneWay(
                                                          flight,
                                                          baggageOption,
                                                          totalPrice,
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  constraints: BoxConstraints(
                                                    minHeight: deviceInfo
                                                            .screenHeight *
                                                        0.65,
                                                    maxHeight: deviceInfo
                                                            .screenHeight *
                                                        0.65,
                                                  ),
                                                  sheetAnimationStyle:
                                                      AnimationStyle(
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    reverseDuration:
                                                        const Duration(
                                                            milliseconds: 500),
                                                  ),
                                                  isScrollControlled: true,
                                                  clipBehavior: Clip.antiAlias,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            deviceInfo
                                                                    .screenWidth *
                                                                0.1),
                                                      ),
                                                      side: BorderSide(
                                                        color: Colors.white,
                                                        width: deviceInfo
                                                                .screenWidth *
                                                            0.005,
                                                      )),
                                                );
                                              },
                                              flight: flightsResults[index],
                                              departureAirportName: flightsResults
                                                          .isNotEmpty &&
                                                      index <
                                                          flightsResults
                                                              .length &&
                                                      flightsResults[index]
                                                          .itineraries
                                                          .isNotEmpty &&
                                                      flightsResults[index]
                                                          .itineraries[0]
                                                          .segments
                                                          .isNotEmpty
                                                  ? getAirportDetails(
                                                              flightsResults[
                                                                      index]
                                                                  .itineraries[0]
                                                                  .segments
                                                                  .last
                                                                  .arrival
                                                                  .iataCode)[
                                                          'name'] ??
                                                      'Unknown Airport'
                                                  : 'Unknown Airport',

                                              arrivalAirportName: flightsResults
                                                          .isNotEmpty &&
                                                      index <
                                                          flightsResults
                                                              .length &&
                                                      flightsResults[index]
                                                          .itineraries
                                                          .isNotEmpty &&
                                                      flightsResults[index]
                                                          .itineraries[0]
                                                          .segments
                                                          .isNotEmpty
                                                  ? getAirportDetails(
                                                              flightsResults[
                                                                      index]
                                                                  .itineraries[0]
                                                                  .segments[0]
                                                                  .departure
                                                                  .iataCode)[
                                                          'name'] ??
                                                      'Unknown Airport'
                                                  : 'Unknown Airport',
                                              // arrivalAirportName: getIt<
                                              //                 FlightSearchQueryParams>()
                                              //             .goOrReturnIndicator ==
                                              //         0
                                              //     ? getIt<AirportsDetails>()
                                              //             .depAirportsDetails![
                                              //         'airportName']
                                              //     : getIt<AirportsDetails>()
                                              //             .arrAirportsDetails![
                                              //         'airportName'],
                                              // departureAirportName: getIt<
                                              //                 FlightSearchQueryParams>()
                                              //             .goOrReturnIndicator ==
                                              //         0
                                              //     ? getIt<AirportsDetails>()
                                              //             .arrAirportsDetails![
                                              //         'airportName']
                                              //     : getIt<AirportsDetails>()
                                              //             .depAirportsDetails![
                                              //         'airportName'],
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

  //^ why it is not 1 function?????????????????????
  /// Handles the sign-in and booking process.
  void handleSignInAndBookingOneWay(
    FlightResultModel flight,
    BaggageOptionModel baggageOption,
    double totalPrice,
  ) async {
    if (await getIt<AuthCubit>().isLoggedIn()) {
      OneWayBookingModel.mapFlightResultToOneWayBooking(
        flightResult: flight,
        baggageOption: baggageOption,
        totalPrice: totalPrice,
      );
      getIt<OneWayBookingModel>().printBookingDetails();
      if (mounted) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return BookingApplicationScreen(
              travelers: getIt<FlightSearchQueryParams>().getTravellersMap());
        }));
      } else {
        return;
      }
    } else {
      MyLogger.red('Not loggedin');
      getIt<AuthNavigationState>().setRedirectRoute(Routes.searchFlightResults);
      if (mounted) {
        Navigator.of(context).pushNamed(Routes.logIn);
      } else {
        return;
      }
    }
  }

  void handleSignInAndBookingRoundTrip(
    FlightResultModel flight,
    BaggageOptionModel baggageOption,
    double totalPrice,
    bool isSecondTrip,
  ) async {
    if (!isSecondTrip) {
      RoundTripBookingModel.mapFlightResultToRoundTripBooking(
        flightResult: flight,
        baggageOption: baggageOption,
        totalPrice: totalPrice,
        isSecondTrip: false,
      );
      return;
    }
    if (await getIt<AuthCubit>().isLoggedIn()) {
      RoundTripBookingModel.mapFlightResultToRoundTripBooking(
        flightResult: flight,
        baggageOption: baggageOption,
        totalPrice: totalPrice,
        isSecondTrip: true,
      );
      getIt<RoundTripBookingModel>().printBookingDetails();

      if (mounted) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return BookingApplicationScreen(
              travelers: getIt<FlightSearchQueryParams>().getTravellersMap());
        }));
      } else {
        return;
      }
    } else {
      MyLogger.red('Not loggedin');
      // Here👋
      getIt<AuthNavigationState>().setRedirectRoute(Routes.searchFlightResults);
      if (mounted) {
        Navigator.of(context).pushNamed(Routes.logIn);
      } else {
        return;
      }
    }
  }
}
