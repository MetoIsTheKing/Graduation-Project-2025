import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flight_actions_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flight_model.dart';

import 'package:graduation_project_2025/features/home/explore/flights/presentation/flights_utils.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flight_card_widget.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flights_class_card_widget.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flights_form_widget.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flights_travellers_card_widget.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flights_travellers_field_widget.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/radio_tiles_row.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/pages/search_airport.dart';
import 'package:intl/intl.dart';

class FlightsScreen extends StatefulWidget {
  // Add this line

  const FlightsScreen({
    super.key,
  }); // Add this line

  @override
  State<FlightsScreen> createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<FlightsScreen> {
  final deviceInfo = getIt<DeviceInfo>();
  String? selectedFlightType = 'option1';
  final PageController _pageController = PageController(initialPage: 0);

  late FlightsUtils flightsUtils;

  final FlightModel flightModel = FlightModel();
  late final FlightActionsModel flightActionsModel;

  List<FlightModel> multiCityList = [];
  @override
  void initState() {
    super.initState();
    multiCityList.add(FlightModel());
    flightActionsModel = FlightActionsModel(
      onAddAnotherFlightPressed: onaddAnotherFlightPressed,
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
    flightModel.dispose();
    for (var flight in multiCityList) {
      flight.dispose();
    }
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

  ///////////////////////////////// Radio tile functions //////////////////////////////

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
              bodyLarge: TextStyles.medium20(deviceInfo, Colors.black).copyWith(
                  fontSize: deviceInfo.screenWidth * 0.035), // Responsive text
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
      !isReturnDate
          ? selecteFlightModel.departureDate = pickedDate
          : selecteFlightModel.returnDate = pickedDate;

      setState(() {
        if (!isReturnDate) {
          selecteFlightModel.departureDateController.text =
              DateFormat("MMMM d, yyyy").format(pickedDate);
        } else {
          selecteFlightModel.returnDateController.text =
              DateFormat("MMMM d, yyyy").format(pickedDate);
        }
      });
    }
  }
  ///////////////////////////////// Date Selection functions //////////////////////////////

  ///////////////////////////////// Buttons onPress functions //////////////////////////////
  void onSearchFlightsPressed(FlightModel selectedFlightModel) {
    dev.log('''************flightModel = *********
      From: ${selectedFlightModel.fromController.text}
      To: ${selectedFlightModel.toController.text}
      Departure Date: ${selectedFlightModel.departureDateController.text}
      Return Date: ${selectedFlightModel.returnDateController.text}
      Travellers: ${selectedFlightModel.travellers.toString()}
      Flight Class: ${selectedFlightModel.flightClass}
    ''');
  }

  void onaddAnotherFlightPressed() {
    setState(() {
      multiCityList.add(FlightModel());
    });
  }

  void onChangeButtonPressed(FlightModel selectedFlightModel) {
    String temp = selectedFlightModel.fromController.text;
    setState(() {
      selectedFlightModel.fromController.text = flightModel.toController.text;
      selectedFlightModel.toController.text = temp;
    });
    dev.log(
        "Changed flight details: from ${flightModel.fromController.text} to ${flightModel.toController.text}");
  }

  void onDeleteCardPressed(int index) {
    setState(() {
      if (multiCityList.length > 1) {
        multiCityList.removeAt(index);
      }
    });
  }

  ///////////////////////////////// Buttons onPress functions //////////////////////////////

  ///////////////////////////////// Fields onTap functions //////////////////////////////
  void onFromFieldTaped(FlightModel selectedFlightModel) {
    setState(() {
      selectedFlightModel.fromController.text = 'Fattooooooor';
    });
  }

  void onToFieldTaped(FlightModel selectedFlightModel) {
    setState(() {
      selectedFlightModel.toController.text = 'Saa7ooooor';
    });
  }

  void onTravellersFieldTaped(FlightModel selectedFlightModel) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            // StatefulBuilder allows UI updates inside the modal
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
                      flightModel: selectedFlightModel,
                      onAddTraveller: (String travellerType) {
                        setModalState(() {
                          selectedFlightModel.travellers[travellerType] =
                              (selectedFlightModel.travellers[travellerType] ??
                                      0) +
                                  1;
                        });
                      },
                      onremoveTraveller: (String travellerType) {
                        setModalState(() {
                          if (selectedFlightModel.travellers[travellerType] !=
                              0) {
                            selectedFlightModel.travellers[travellerType] =
                                (selectedFlightModel
                                            .travellers[travellerType] ??
                                        0) -
                                    1;
                          }
                        });
                      },
                    ),
                    FlightsClassCardWidget(
                      onSelectedFlightClass: (String? value) {
                        setModalState(() {
                          selectedFlightModel.flightClass = value!;
                        }); // Update state inside modal
                      },
                      flightModel: selectedFlightModel,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
    setState(() {
      int totalTravellers =
          selectedFlightModel.travellers.values.reduce((a, b) => a + b);
      selectedFlightModel.travellersController.text = totalTravellers == 0
          ? ''
          : '${totalTravellers.toString()} Travellers , ${selectedFlightModel.flightClass}';
    });

    dev.log('----------------------------> ${selectedFlightModel.travellers}');
  }
///////////////////////////////// Fields onTap functions //////////////////////////////

  @override
  Widget build(BuildContext context) {
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
                    padding:
                        EdgeInsets.only(top: deviceInfo.screenHeight * 0.08),
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
                        context.pushReplacementNamed(Routes.mainHome);
                      },
                    ),
                    title: Text(
                      'Search Flights',
                      style: TextStyles.semiBold18(deviceInfo, Colors.white),
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
                            style: TextStyles.bold34(deviceInfo, Colors.white),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: deviceInfo.screenWidth * 0.02,
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
                            child: Form(
                              child: Column(
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
                                        physics: NeverScrollableScrollPhysics(),
                                        children: [
                                          FlightsFormWidget(
                                            flightModel: flightModel,
                                            flightActionsModel:
                                                flightActionsModel,
                                          ),
                                          FlightsFormWidget(
                                            flightModel: flightModel,
                                            flightActionsModel:
                                                flightActionsModel,
                                            isTwoWay: true,
                                          ),
                                          SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      multiCityList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final FlightModel
                                                        flightCardModel =
                                                        multiCityList[index];

                                                    return FlightCardWidget(
                                                      flightModel:
                                                          flightCardModel,
                                                      flightActionsModel:
                                                          flightActionsModel,
                                                      onDeleteCardPressed:
                                                          onDeleteCardPressed,
                                                      index: index,
                                                    );
                                                  },
                                                ),
                                                selectedFlightType == 'option3'
                                                    ? CustomRoundedButton(
                                                        deviceInfo: deviceInfo,
                                                        label:
                                                            'add another flight ?',
                                                        backgroundColor:
                                                            Colors.white,
                                                        onPressed:
                                                            flightActionsModel
                                                                .onAddAnotherFlightPressed,
                                                        textColor:
                                                            AppColors.appBlue,
                                                      )
                                                    : SizedBox(),
                                                CustomRoundedButton(
                                                  deviceInfo: deviceInfo,
                                                  label: 'Search Flights',
                                                  backgroundColor:
                                                      AppColors.appBlue,
                                                  onPressed: () {
                                                    // TODO: what happens when search flights is presased in multylist?
                                                  },
                                                  textColor: Colors.white,
                                                ),
                                                SizedBox(
                                                  height:
                                                      deviceInfo.screenHeight *
                                                          0.03,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: deviceInfo.screenHeight * 0.05,
                                  // )
                                ],
                              ),
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
  }
}
