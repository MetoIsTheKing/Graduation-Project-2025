import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flight_actions_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flight_model.dart';

import 'package:graduation_project_2025/features/home/explore/flights/presentation/flights_utils.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flight_card_widget.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flights_form_widget.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/radio_tiles_row.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/pages/search_airport.dart';

class FlightsScreen extends StatefulWidget {
  const FlightsScreen({super.key});

  @override
  State<FlightsScreen> createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<FlightsScreen> {
  final deviceInfo = getIt<DeviceInfo>();
  String? selectedFlightType = 'option1';
  final PageController _pageController = PageController(initialPage: 0);
  double _pageViewHeight = 0;

  final FlightModel flightModel = FlightModel();
  late final FlightActionsModel flightActionsModel;

  List<FlightModel> multiCityList = [];
  @override
  void initState() {
    super.initState();
    _pageViewHeight = FlightsUtils.firstPageHeight;
    flightActionsModel = FlightActionsModel(
      onDepartureDateSelected: onDepartureDateSelected,
      onReturnDateSelected: onReturnDateSelected,
      onFromFieldTaped: onFromFieldTaped,
      onToFieldTapped: onToFieldTaped,
      onTravellersFieldTapped: onTravellersFieldTaped,
      onChangePressed: onChangeButtonPressed,
      onAddReturnDateTapped: onaddReturnDatePressed,
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
      // Update the height of the AnimatedContainer first
      // -1 is for the default height during animation
      _pageViewHeight = _getPageHeight(-1);
      // Delay the horizontal animation to allow the vertical animation to complete first
      Future.delayed(FlightsUtils.verticalAnimationDuration, () {
        _pageController
            .animateToPage(
          pageIndex,
          duration: FlightsUtils.horizontalAnimationDuration,
          curve: Curves.easeInOut,
        )
            .then((_) {
          // Set _isAnimating to false after the animation completes
          setState(() {
            _pageViewHeight = _getPageHeight(pageIndex);
          });
        });
      });
    });
  }
  ///////////////////////////////// Radio tile functions //////////////////////////////

  ///////////////////////////////// Date Selection functions //////////////////////////////
  void onDepartureDateSelected(DateTime? selectedDate) {
    setState(() {
      flightModel.departureDate = selectedDate;
    });
  }

  void onReturnDateSelected(DateTime? selectedDate) {
    setState(() {
      flightModel.returnDate = selectedDate;
    });
  }
  ///////////////////////////////// Date Selection functions //////////////////////////////

  ///////////////////////////////// Buttons onPress functions //////////////////////////////
  void onSearchFlightsPressed() {
    setState(() {
      flightModel.fromController.text = "ggggggggg";
      flightModel.toController.text = "hhhhhhhhhhh";
    });
  }

  void onaddAnotherFlightPressed() {
    setState(() {
      multiCityList.add(FlightModel());
    });
  }

  void onaddReturnDatePressed() {}

  void onChangeButtonPressed() {
    String temp = flightModel.fromController.text;
    setState(() {
      flightModel.fromController.text = flightModel.toController.text;
      flightModel.toController.text = temp;
    });
    dev.log(
        "Changed flight details: from ${flightModel.fromController.text} to ${flightModel.toController.text}");
  }

  void onDeleteCardPressed(int index) {
    setState(() {
      multiCityList.removeAt(index);
    });
  }
  ///////////////////////////////// Buttons onPress functions //////////////////////////////

  ///////////////////////////////// Fields onTap functions //////////////////////////////
  void onFromFieldTaped() {
    dev.log("fromFieldTaped");
  }

  void onToFieldTaped() {}

  void onTravellersFieldTaped() {}
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
              Scaffold(
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
                    style: FlightsUtils.titleStyle,
                  ),
                ),
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: FlightsUtils.subTitlePadding,
                        child: Text(
                          'Discover\na new World',
                          style: FlightsUtils.subTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        padding: FlightsUtils.whiteContainerPadding,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                FlightsUtils.backGroundBorderRadius),
                            topRight: Radius.circular(
                                FlightsUtils.backGroundBorderRadius),
                          ),
                        ),
                        child: Form(
                          child: Column(
                            children: [
                              SizedBox(
                                width: FlightsUtils.radioTilesRowWidth,
                                child: RadioTilesRow(
                                  selectedFlightType: selectedFlightType,
                                  onSelectedFlightType: onSelectedFlightType,
                                ),
                              ),
                              Padding(
                                padding: FlightsUtils.mainContentPadding,
                                child: Column(
                                  children: [
                                    LayoutBuilder(
                                      builder: (context, constraints) {
                                        return AnimatedContainer(
                                          duration: FlightsUtils
                                              .verticalAnimationDuration,
                                          height: _pageViewHeight,
                                          //////////////// pageView
                                          child: PageView(
                                            controller: _pageController,
                                            physics:
                                                NeverScrollableScrollPhysics(),
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
                                              ListView.builder(
                                                itemCount: multiCityList.length,
                                                itemBuilder: (context, index) {
                                                  final FlightModel
                                                      flightCardModel =
                                                      multiCityList[index];
                                                  // you can remove the below
                                                  flightCardModel.fromController
                                                      .text = "$index";
                                                  flightCardModel.toController
                                                      .text = "${index + 1}";
                                                  dev.log(
                                                      "fromController.text: ${flightCardModel.fromController.text}");
                                                  return Column(
                                                    children: [
                                                      FlightCardWidget(
                                                        flightModel:
                                                            flightCardModel,
                                                        flightActionsModel:
                                                            flightActionsModel,
                                                        onDeleteCardPressed:
                                                            onDeleteCardPressed,
                                                        index: index,
                                                      ),
                                                      SizedBox(
                                                        height: deviceInfo
                                                                .screenHeight *
                                                            0.02,
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: deviceInfo.screenHeight * 0.02,
                                    ),
                                    selectedFlightType == 'option3'
                                        ? Column(
                                            children: [
                                              CustomRoundedButton(
                                                deviceInfo: deviceInfo,
                                                label: 'Add another flight?',
                                                backgroundColor: Colors.white,
                                                onPressed:
                                                    onaddAnotherFlightPressed,
                                                textColor: AppColors.appBlue,
                                              ),
                                              SizedBox(
                                                height:
                                                    deviceInfo.screenHeight *
                                                        0.02,
                                              ),
                                            ],
                                          )
                                        : SizedBox(),
                                    CustomRoundedButton(
                                      deviceInfo: deviceInfo,
                                      label: 'Search Flights',
                                      backgroundColor: AppColors.appBlue,
                                      onPressed: () {
                                        onSearchFlightsPressed();
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => SearchAirport(
                                              appBarTitle: 'Search Origin',
                                              isOrigin: true,
                                              onBack: context.pop,
                                            ),
                                          ),
                                        );
                                      },
                                      textColor: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: deviceInfo.screenHeight * 0.1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  double _getPageHeight(int index) {
    final deviceInfo = getIt<DeviceInfo>();

    // Return the height for each page based on the index
    switch (index) {
      case 0:
        return FlightsUtils.firstPageHeight; // Height for the first page
      case 1:
        return FlightsUtils.secondPageHeight; // Height for the second page
      case 2:
        return FlightsUtils.thirdPageHeight; // Height for the third page
      default:
        return deviceInfo.screenHeight; // Default height during animation
    }
  }
}
