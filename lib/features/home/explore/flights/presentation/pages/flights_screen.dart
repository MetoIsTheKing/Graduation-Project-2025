import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
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
      _pageController.animateToPage(
        pageIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
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

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo, constrains) {
      return Scaffold(
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
                                child: SizedBox(
                                  height: deviceInfo.screenHeight,
                                  child: PageView(
                                    controller: _pageController,
                                    physics:
                                        NeverScrollableScrollPhysics(), // Disable swipe
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
                                        onFromFieldTaped: () {},
                                        onTravellersFieldTapped: () {},
                                        onToFieldTapped: () {},
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
                                        onFromFieldTaped: () {
                                          dev.log('from');
                                        },
                                        onTravellersFieldTapped: () {
                                          dev.log('travellers');
                                        },
                                        onToFieldTapped: () {
                                          dev.log('to');
                                        },
                                      ),
                                      Text("Hello", style: TextStyle()),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: deviceInfo.screenHeight * 0.1,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
