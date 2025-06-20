import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/routing/arguments.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/flights_data_cubit.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/search_flights/search_flights_cubit.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flight_actions_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flight_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flights_utils.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/pages/search_airport.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flights_class_card_widget.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flights_form_widget.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flights_travellers_card_widget.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/radio_tiles_row.dart';

class FlightsScreen extends StatefulWidget {
  final AirportsDetails? airportsDetails;
  const FlightsScreen({super.key, this.airportsDetails});

  @override
  State<FlightsScreen> createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<FlightsScreen> {
  final deviceInfo = getIt<DeviceInfo>();
  String? selectedFlightType = 'option1';
  final PageController _pageController = PageController(initialPage: 0);
  late FlightsUtils flightsUtils;
  late final FlightActionsModel flightActionsModel;

  //////

  //this suppose to initiate that cubit👇
  late FlightsDataCubit flightsDataCubit;
  late SearchFlightsCubit searchFlightCubit;

  @override
  void initState() {
    super.initState();
    flightsDataCubit = getIt<FlightsDataCubit>();
    searchFlightCubit = getIt<SearchFlightsCubit>();
    flightActionsModel = FlightActionsModel(
      onSearchFlightsPressed: onSearchFlightsPressed,
      onFromFieldTaped: onFromFieldTaped,
      onToFieldTapped: onToFieldTaped,
      onTravellersFieldTapped: onTravellersFieldTaped,
      onChangePressed: onChangeButtonPressed,
      onDatePickerTapped: onDatePickerTapped,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  ///////////////////////////////// Radio tile functions //////////////////////////////
  void onSelectedFlightType(String? value) {
    setState(() {
      selectedFlightType = value;
      int pageIndex;
      if (value == 'option1') {
        pageIndex = 0;
      } else if (value == 'option2') {
        pageIndex = 1;
      } else {
        pageIndex = 2;
      }

      _pageController.animateToPage(
        pageIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  ///////////////////////////////// Date Selection functions //////////////////////////////
  Future<void> onDatePickerTapped({
    required FlightModel selecteFlightModel,
    bool isReturnDate = false,
  }) async {
    DateTime? pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        DateTime? tempPickedDate = !isReturnDate
            ? selecteFlightModel.departureDate
            : selecteFlightModel.returnDate;

        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: AppColors.appBlue,
            ),
            textTheme: TextTheme(
              bodyLarge: TextStyles.medium20(deviceInfo, Colors.black)
                  .copyWith(fontSize: deviceInfo.screenWidth * 0.035),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Select Date",
                  style: TextStyles.mediumDark16
                      .copyWith(fontSize: deviceInfo.screenWidth * 0.05),
                ),
              ),
              CalendarDatePicker(
                currentDate: DateTime.now(),
                initialDate: tempPickedDate ?? DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2030),
                onDateChanged: (date) {
                  tempPickedDate = date;
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, tempPickedDate);
                },
                child: Text(
                  "Select",
                  style: TextStyles.medium20(deviceInfo, Colors.blue)
                      .copyWith(fontSize: deviceInfo.screenWidth * 0.05),
                ),
              ),
              SizedBox(height: deviceInfo.screenHeight * 0.03),
            ],
          ),
        );
      },
    );

    if (pickedDate != null) {
      final cubit = context.read<FlightsDataCubit>();
      if (!isReturnDate) {
        cubit.updateDepartureDate(pickedDate);
        dev.log('dep date inside cubit = $pickedDate');
        // selecteFlightModel.departureDateController.text =
        //     DateFormat("MMMM d, yyyy").format(pickedDate);
      } else {
        cubit.updateReturnDate(pickedDate);
        // selecteFlightModel.returnDateController.text =
        //     DateFormat("MMMM d, yyyy").format(pickedDate);
      }
    }
  }

  ///////////////////////////////// Buttons onPress functions //////////////////////////////
  void onSearchFlightsPressed(FlightModel selectedFlightModel) {
    final queryParams = {
      "originLocationCode": flightsDataCubit.state.fromController.text,
      "destinationLocationCode": flightsDataCubit.state.toController.text,
      if (flightsDataCubit.state.departureDateController.text.isNotEmpty)
        "departureDate": flightsDataCubit.state.departureDateController.text
            .substring(0, 10),
      if (flightsDataCubit.state.returnDateController.text.isNotEmpty)
        "returnDate":
            flightsDataCubit.state.returnDateController.text.substring(0, 10),
      "adults": flightsDataCubit.state.travellers['adults'],
      if (flightsDataCubit.state.travellers['children'] != (0))
        "children": flightsDataCubit.state.travellers['children'],
      if (flightsDataCubit.state.travellers['infants'] != (0))
        "infants": flightsDataCubit.state.travellers['infants'],
      "travelClass": flightsDataCubit.state.flightClass,
      "nonStop": false,
      "max": 250,
      "currencyCode": "USD",
    };
    dev.log("thsi is queryParams : $queryParams");
    dev.log(getIt<AirportsDetails>().arrAirportsDetails.toString());
    dev.log(getIt<AirportsDetails>().depAirportsDetails.toString());
    final travelersMap = {
      "adults": flightsDataCubit.state.travellers['adults'],
      if (flightsDataCubit.state.travellers['children'] != (0))
        "children": flightsDataCubit.state.travellers['children'],
      if (flightsDataCubit.state.travellers['infants'] != (0))
        "infants": flightsDataCubit.state.travellers['infants'],
    };
    searchFlightCubit.searchFlights(queryParams);
    context.pushNamed(Routes.searchFlightResults, arguments: queryParams);
  }

  void onChangeButtonPressed(FlightModel selectedFlightModel) {
    //final cubit = context.read<FlightsDataCubit>();
    final currentState = flightsDataCubit.state;

    setState(() {
      // Swap values in the cubit
      flightsDataCubit.updateFrom(currentState.toController.text);
      flightsDataCubit.updateTo(currentState.fromController.text);

      // Update local controller texts
      selectedFlightModel.fromController.text = currentState.toController.text;
      selectedFlightModel.toController.text = currentState.fromController.text;
    });

    dev.log(
        "Changed flight details: from ${currentState.fromController.text} to ${currentState.toController.text}");
  }

  ///////////////////////////////// Fields onTap functions //////////////////////////////
  void onFromFieldTaped(FlightModel selectedFlightModel) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchAirport(
          searchFlightsCubit: searchFlightCubit,
          args: SearchAirportArguments(
              cubit: flightsDataCubit,
              appBarTitle: 'Search Origin',
              isOrigin: true,
              flightModel: flightsDataCubit.state,
              onBack: context.pop),
        ),
      ),
    );
  }

  void onToFieldTaped(FlightModel selectedFlightModel) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchAirport(
          searchFlightsCubit: searchFlightCubit,
          args: SearchAirportArguments(
              cubit: flightsDataCubit,
              appBarTitle: 'Search Destination',
              isOrigin: false,
              flightModel: flightsDataCubit.state,
              onBack: context.pop),
        ),
      ),
    );
  }

  void onTravellersFieldTaped() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxWidth: deviceInfo.screenWidth,
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final cubit = getIt<FlightsDataCubit>();
            return Container(
              height: deviceInfo.screenHeight * 0.76,
              padding: EdgeInsets.symmetric(
                horizontal: deviceInfo.screenWidth * 0.02,
                vertical: deviceInfo.screenHeight * 0.01,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(deviceInfo.screenHeight * 0.05),
                  topRight: Radius.circular(deviceInfo.screenHeight * 0.05),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FlightsTravellersCardWidget(
                      flightModel: cubit.state,
                      onAddTraveller: (String travellerType) {
                        final updatedTravellers =
                            Map<String, int>.from(cubit.state.travellers);
                        updatedTravellers[travellerType] =
                            (updatedTravellers[travellerType] ?? 0) + 1;
                        setModalState(() {
                          cubit.updateTravellers(
                              travellerType, updatedTravellers[travellerType]!);
                        });
                      },
                      onremoveTraveller: (String travellerType) {
                        final updatedTravellers =
                            Map<String, int>.from(cubit.state.travellers);

                        if (updatedTravellers[travellerType] != null &&
                            updatedTravellers[travellerType]! > 0) {
                          updatedTravellers[travellerType] =
                              updatedTravellers[travellerType]! - 1;
                          setModalState(() {});
                          cubit.updateTravellers(
                              travellerType, updatedTravellers[travellerType]!);
                        }
                      },
                    ),
                    FlightsClassCardWidget(
                      onSelectedFlightClass: (String? value) {
                        setModalState(() {
                          cubit.updateFlightClass(value!);
                        });
                      },
                      flightModel: cubit.state,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    // Update travellers text after modal closes
    final cubit = context.read<FlightsDataCubit>();
    final totalTravellers =
        cubit.state.travellers.values.reduce((a, b) => a + b);
    cubit.state.travellersController.text = totalTravellers == 0
        ? ''
        : '${totalTravellers.toString()} Travellers , ${cubit.state.flightClass}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlightsDataCubit, FlightModel>(
      builder: (context, flightModel) {
        return InfoWidget(builder: (context, deviceInfo, constrains) {
          return Scaffold(
            backgroundColor: AppColors.appBlue,
            body: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: deviceInfo.screenHeight * 0.08),
                        color: AppColors.appBlue,
                        child: Image.asset('assets/images/global_map.png'),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SafeArea(
                    child: Scaffold(
                      appBar: AppBar(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        centerTitle: true,
                        leading: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: deviceInfo.screenWidth * 0.04,
                          ),
                          onPressed: () {
                            context.pushReplacementNamed(Routes.explore);
                          },
                        ),
                        title: Text(
                          'Search Flights',
                          style:
                              TextStyles.semiBold18(deviceInfo, Colors.white),
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                      body: SizedBox(
                        height: deviceInfo.screenHeight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  deviceInfo.screenWidth * 0.05,
                                  deviceInfo.screenHeight * 0.01,
                                  deviceInfo.screenWidth * 0.05,
                                  deviceInfo.screenHeight * 0.01),
                              child: Text(
                                'Discover\na new World',
                                style:
                                    TextStyles.bold34(deviceInfo, Colors.white),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: deviceInfo.screenWidth * 0.01,
                                  vertical: deviceInfo.screenHeight * 0.001,
                                ),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        deviceInfo.screenHeight * 0.05),
                                    topRight: Radius.circular(
                                        deviceInfo.screenHeight * 0.05),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: deviceInfo.screenWidth * 0.85,
                                      child: RadioTilesRow(
                                        selectedFlightType: selectedFlightType,
                                        onSelectedFlightType:
                                            onSelectedFlightType,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              deviceInfo.screenWidth * 0.05,
                                          vertical:
                                              deviceInfo.screenHeight * 0.005,
                                        ),
                                        child: PageView(
                                          controller: _pageController,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          children: [
                                            FlightsFormWidget(
                                              dataCubit: context
                                                  .read<FlightsDataCubit>(),
                                              flightModel: context
                                                  .read<FlightsDataCubit>()
                                                  .state,
                                              flightActionsModel:
                                                  flightActionsModel,
                                            ),
                                            FlightsFormWidget(
                                              dataCubit: context
                                                  .read<FlightsDataCubit>(),
                                              flightModel: flightModel,
                                              flightActionsModel:
                                                  flightActionsModel,
                                              isTwoWay: true,
                                            ),
                                          ],
                                        ),
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
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
