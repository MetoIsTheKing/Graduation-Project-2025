import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/routing/arguments.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/helpers/my_logger.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/flights_data_cubit.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/search_flights/search_flights_cubit.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/models/flight_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/pages/search_airport.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/search_flights/flights_class_card_widget.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/search_flights/flights_form_widget.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/search_flights/flights_travellers_card_widget.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/search_flights/radio_tiles_row.dart';

class SearchFlightsScreen extends StatefulWidget {
  final AirportsDetails? airportsDetails;
  const SearchFlightsScreen({super.key, this.airportsDetails});

  @override
  State<SearchFlightsScreen> createState() => _SearchFlightsScreenState();
}

class _SearchFlightsScreenState extends State<SearchFlightsScreen> {
  String? selectedFlightType = 'option1';
  final PageController _pageController = PageController(initialPage: 0);

  //? Form controllers
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _departureDateController =
      TextEditingController();
  late DateTime? departureDate = DateTime.now();
  final TextEditingController _returnDateController = TextEditingController();
  late DateTime? returnDate = DateTime.now().add(const Duration(days: 1));
  final TextEditingController travellersController =
      TextEditingController(text: '1 Traveller , Economy');
  late Map<String, int> travellers = {
    'adults': 1,
    'children': 0,
    'infants': 0,
  };
  late String flightClass = 'ECONOMY';
  late bool isNonStop = true;

  late bool isRoundTrip = false;
  final formKey = GlobalKey<FormState>();

  late FlightsDataCubit flightsDataCubit;
  late SearchFlightsCubit searchFlightCubit;

  @override
  void initState() {
    super.initState();
    flightsDataCubit = getIt<FlightsDataCubit>();
    searchFlightCubit = getIt<SearchFlightsCubit>();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fromController.dispose();
    _toController.dispose();
    _departureDateController.dispose();
    _returnDateController.dispose();
    travellersController.dispose();
    formKey.currentState?.dispose();

    super.dispose();
  }

  void onSelectedFlightType(String? value) {
    setState(() {
      selectedFlightType = value;
      if (value == 'option1') {
        isRoundTrip = false;
      } else if (value == 'option2') {
        isRoundTrip = true;
      } else {
        isRoundTrip = false;
      }
    });
  }

  // Helper method to show date picker
  Future<void> _showDatePicker(bool isReturnDate) async {
    DateTime? tempPickedDate = isReturnDate ? returnDate : departureDate;

    DateTime? pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return InfoWidget(builder: (context, deviceInfo, constraints) {
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
                    isReturnDate
                        ? "Select Return Date"
                        : "Select Departure Date",
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
        });
      },
    );

    if (pickedDate != null) {
      setState(() {
        if (isReturnDate) {
          returnDate = pickedDate;
          _returnDateController.text = pickedDate.toString().substring(0, 10);
        } else {
          departureDate = pickedDate;
          _departureDateController.text =
              pickedDate.toString().substring(0, 10);
        }
      });
    }
  }

  ///////////////////////////////// Buttons onPress functions //////////////////////////////
  void onSearchFlightsPressed() {
    if (formKey.currentState!.validate()) {
      getIt<FlightSearchQueryParams>().isRoundTrip = isRoundTrip;
      getIt<FlightSearchQueryParams>()
        ..originLocationCode = _fromController.text
        ..destinationLocationCode = _toController.text
        ..departureDate = _departureDateController.text
        ..returnDate = _returnDateController.text
        ..adults = travellers['adults']!
        ..children = travellers['children']!
        ..infants = travellers['infants']!
        ..travelClass = flightClass
        ..nonStop = !isNonStop
        ..max = 10
        ..currencyCode = 'USD';
      MyLogger.green(
          'Query Params: ${getIt<FlightSearchQueryParams>().toGoMap()}');
      context.pushNamed(Routes.searchFlightResults);
    } else {
      MyLogger.red('fucccccccccccck');
    }
  }

  void onChangeButtonPressed() {
    String tempText = _fromController.text;
    setState(() {
      _fromController.text = _toController.text;
      _toController.text = tempText;
      Map<String, dynamic>? tempMap =
          getIt<AirportsDetails>().depAirportsDetails;
      getIt<AirportsDetails>().depAirportsDetails =
          getIt<AirportsDetails>().arrAirportsDetails;
      getIt<AirportsDetails>().arrAirportsDetails = tempMap;
    });
  }

  ///////////////////////////////// Fields onTap functions //////////////////////////////
  void onFromFieldTaped() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchAirport(
          searchFlightsCubit: searchFlightCubit,
          args: SearchAirportArguments(
              fromController: _fromController,
              toController: _toController,
              appBarTitle: 'Search Origin',
              isOrigin: true,
              onBack: context.pop),
        ),
      ),
    );
  }

  void onToFieldTaped() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchAirport(
          searchFlightsCubit: searchFlightCubit,
          args: SearchAirportArguments(
              fromController: _fromController,
              toController: _toController,
              appBarTitle: 'Search Destination',
              isOrigin: false,
              onBack: context.pop),
        ),
      ),
    );
  }

  void onTravellersFieldTaped(
      DeviceInfo deviceInfo, Map<String, int> travellers) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxWidth: deviceInfo.screenWidth,
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
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
                      travellers: travellers,
                      onAddTraveller: (String travellerType) {
                        setModalState(() {
                          travellers[travellerType] =
                              (travellers[travellerType] ?? 0) + 1;
                        });
                      },
                      onremoveTraveller: (String travellerType) {
                        setModalState(() {
                          if (travellers[travellerType]! > 0) {
                            travellers[travellerType] =
                                (travellers[travellerType] ?? 0) - 1;
                          }
                        });
                      },
                    ),
                    FlightsClassCardWidget(
                      flightClass: flightClass,
                      onSelectedFlightClass: (String? value) {
                        setModalState(() {
                          flightClass = value!;
                        });
                      },
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
    final totalTravellers = travellers.values.reduce((a, b) => a + b);
    travellersController.text = totalTravellers == 0
        ? ''
        : '${totalTravellers.toString()} Travellers , $flightClass';
  }

  void onNonStopChanged(bool? value) {
    setState(() {
      isNonStop = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlightsDataCubit, FlightModel>(
      builder: (context, flightModel) {
        return InfoWidget(builder: (context, deviceInfo, constrains) {
          return Scaffold(
            backgroundColor: AppColors.appBlue,
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
                style: TextStyles.semiBold18(deviceInfo, Colors.white),
              ),
            ),
            body: SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Stack(children: [
                  //* bg image and color
                  Container(
                    padding:
                        EdgeInsets.only(top: deviceInfo.screenHeight * 0.02),
                    color: AppColors.appBlue,
                    child: Image.asset('assets/images/global_map.png'),
                  ),
                  //* main content
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            deviceInfo.screenWidth * 0.05,
                            deviceInfo.screenHeight * 0.01,
                            deviceInfo.screenWidth * 0.05,
                            deviceInfo.screenHeight * 0.015),
                        child: Text(
                          'Discover\na new World',
                          style: TextStyles.bold34(deviceInfo, Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: deviceInfo.screenWidth * 0.01,
                          vertical: deviceInfo.screenHeight * 0.002,
                        ),
                        constraints: BoxConstraints(
                            maxHeight: deviceInfo.screenHeight * 0.8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft:
                                Radius.circular(deviceInfo.screenHeight * 0.05),
                            topRight:
                                Radius.circular(deviceInfo.screenHeight * 0.05),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RadioTilesRow(
                              selectedFlightType: selectedFlightType,
                              onSelectedFlightType: onSelectedFlightType,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: deviceInfo.screenWidth * 0.05,
                              ),
                              child: Form(
                                key: formKey,
                                child: FlightsFormWidget(
                                  deviceInfo: deviceInfo,
                                  fromController: _fromController,
                                  toController: _toController,
                                  departureDateController:
                                      _departureDateController,
                                  returnDateController: _returnDateController,
                                  travellersController: travellersController,
                                  departureDate: departureDate,
                                  returnDate: returnDate,
                                  onFromFieldTapped: onFromFieldTaped,
                                  onToFieldTapped: onToFieldTaped,
                                  onChangePressed: onChangeButtonPressed,
                                  onDatePickerTapped: (
                                      {bool isReturnDate = false}) async {
                                    await _showDatePicker(isReturnDate);
                                  },
                                  onSearchFlightsPressed:
                                      onSearchFlightsPressed,
                                  onTravellersFieldTapped: () =>
                                      onTravellersFieldTaped(
                                    deviceInfo,
                                    travellers,
                                  ),
                                  onNonStopChanged: onNonStopChanged,
                                  isRoundTrip: isRoundTrip,
                                  isNonStop: isNonStop,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          );
        });
      },
    );
  }
}
