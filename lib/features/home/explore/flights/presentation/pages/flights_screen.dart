import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flight_card_model.dart';

import 'package:graduation_project_2025/features/home/explore/flights/presentation/flights_utils.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flights_type_content.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/radio_tiles_row.dart';

class FlightsScreen extends StatefulWidget {
  const FlightsScreen({super.key});

  @override
  State<FlightsScreen> createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<FlightsScreen> {
  String? selectedFlightType = 'option1';
  final PageController _pageController = PageController(initialPage: 0);
  double _pageViewHeight = 0;
  bool _isAnimating = false;

  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController travellersController = TextEditingController();
  DateTime? departureDate;
  DateTime? returnDate;
  List<FlightCardModel>? multiCityList;

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
      // Set _isAnimating to true before starting the animation
      _isAnimating = true;

      // Update the height of the AnimatedContainer first
      _pageViewHeight = _getPageHeight(pageIndex);

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
            _isAnimating = false;
            _pageViewHeight = _getPageHeight(pageIndex);
          });
        });
      });
    });
  }

  void onChangeButtonPressed() {
    String temp = fromController.text;
    setState(() {
      fromController.text = toController.text;
      toController.text = temp;
    });
  }

  void onDepartureDateSelected(DateTime? selectedDate) {
    setState(() {
      departureDate = selectedDate;
    });
  }

  void onReturnDateSelected(DateTime? selectedDate) {
    setState(() {
      returnDate = selectedDate;
    });
  }

  void onSearchFlightsPressed() {
    setState(() {
      fromController.text = "ggggggggg";
      toController.text = "hhhhhhhhhhh";
    });
  }

  void onaddAnotherFlightPressed() {
    setState(() {
      fromController.text = "ggggggggg";
      toController.text = "hhhhhhhhhhh";
    });
  }

  void onFromFieldTaped() {}
  void onToFieldTaped() {}
  void onTravellersFieldTaped() {}

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo, constrains) {
      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: deviceInfo.screenHeight * 0.08),
                color: AppColors.appBlue,
                child: Image.asset('assets/images/global_map.png'),
              ),
              Scaffold(
                appBar: AppBar(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  title: Text(
                    'Search Flights',
                    style: FlightsUtils.titleStyle,
                  ),
                ),
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: deviceInfo.screenWidth * 0.05,
                          vertical: deviceInfo.screenHeight * 0.03,
                        ),
                        child: Text(
                          'Discover\na new World',
                          style: FlightsUtils.subTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: deviceInfo.screenWidth * 0.02,
                          vertical: deviceInfo.screenHeight * 0.01,
                        ),
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
                              SizedBox(
                                height: deviceInfo.screenHeight * 0.02,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: deviceInfo.screenWidth * 0.05),
                                child: Column(
                                  children: [
                                    LayoutBuilder(
                                      builder: (context, constraints) {
                                        return AnimatedContainer(
                                          duration: FlightsUtils
                                              .verticalAnimationDuration,
                                          height: _pageViewHeight,
                                          child: PageView(
                                            controller: _pageController,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            onPageChanged: (index) {
                                              setState(() {
                                                _pageViewHeight =
                                                    _getPageHeight(index);
                                              });
                                            },
                                            children: [
                                              FlightsTypeContent(
                                                fromController: fromController,
                                                toController: toController,
                                                travellersController:
                                                    travellersController,
                                                selectedDate: departureDate,
                                                onDepartureDateSelected:
                                                    onDepartureDateSelected,
                                                onReturnDateSelected:
                                                    onReturnDateSelected,
                                                onChangeButtonPressed:
                                                    onChangeButtonPressed,
                                                onSearchFlightsPressed:
                                                    onSearchFlightsPressed,
                                                onFromFieldTaped:
                                                    onFromFieldTaped,
                                                onToFieldTapped: onToFieldTaped,
                                                onTravellersFieldTapped:
                                                    onTravellersFieldTaped,
                                              ),
                                              FlightsTypeContent(
                                                fromController: fromController,
                                                toController: toController,
                                                travellersController:
                                                    travellersController,
                                                selectedDate: departureDate,
                                                isTwoWay: true,
                                                returnDate: returnDate,
                                                onDepartureDateSelected:
                                                    onDepartureDateSelected,
                                                onReturnDateSelected:
                                                    onReturnDateSelected,
                                                onChangeButtonPressed:
                                                    onChangeButtonPressed,
                                                onSearchFlightsPressed:
                                                    onSearchFlightsPressed,
                                                onFromFieldTaped:
                                                    onFromFieldTaped,
                                                onToFieldTapped: onToFieldTaped,
                                                onTravellersFieldTapped:
                                                    onTravellersFieldTaped,
                                              ),
                                              Text("Hello", style: TextStyle()),
                                            ],
                                          ),
                                        );
                                      },
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
                                      onPressed: onSearchFlightsPressed,
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

    // Return a special height during animations
    if (_isAnimating) {
      return deviceInfo.screenHeight; // Special height during animations
    }
    // Return the height for each page based on the index
    switch (index) {
      case 0:
        return deviceInfo.screenHeight * 0.55; // Height for the first page
      case 1:
        return deviceInfo.screenHeight * 0.7; // Height for the second page
      case 2:
        return deviceInfo.screenHeight * 0.4; // Height for the third page
      default:
        return deviceInfo.screenHeight * 0.5; // Default height
    }
  }
}
