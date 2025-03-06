import 'package:flutter/material.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flights_utils.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flights_field.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/radio_tiles_row.dart';

class FlightsScreen extends StatefulWidget {
  const FlightsScreen({super.key});

  @override
  State<FlightsScreen> createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<FlightsScreen> {
  String? selectedFlightType = 'option1';
  TextEditingController? fromController;
  TextEditingController? toController;

  void onSelectedFlightType(String? value) {
    setState(() {
      selectedFlightType = value;
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'From',
                                    style: FlightsUtils.fieldLabelStyle,
                                  ),
                                  SizedBox(
                                    height: deviceInfo.screenHeight * 0.01,
                                  ),
                                  FlightsField(
                                    controller: fromController,
                                    prefixIcon: 'assets/images/flight_from.png',
                                    label: 'select start location',
                                  ),
                                  SizedBox(
                                    height: deviceInfo.screenHeight * 0.03,
                                  ),
                                  Text(
                                    'To',
                                    style: FlightsUtils.fieldLabelStyle,
                                  ),
                                  SizedBox(
                                    height: deviceInfo.screenHeight * 0.01,
                                  ),
                                  FlightsField(
                                    controller: fromController,
                                    prefixIcon: 'assets/images/flight_to.png',
                                    label: 'select destination',
                                  ),
                                  SizedBox(
                                    height: deviceInfo.screenHeight * 0.03,
                                  ),
                                  Text(
                                    'Departure Date',
                                    style: FlightsUtils.fieldLabelStyle,
                                  ),
                                  SizedBox(
                                    height: deviceInfo.screenHeight * 0.01,
                                  ),
                                  FlightsField(
                                      controller: fromController,
                                      prefixIcon:
                                          'assets/images/flights_calender.png',
                                      label: 'select departure date'),
                                  SizedBox(
                                    height: deviceInfo.screenHeight * 0.03,
                                  ),
                                  Text(
                                    'Travelers',
                                    style: FlightsUtils.fieldLabelStyle,
                                  ),
                                  SizedBox(
                                    height: deviceInfo.screenHeight * 0.01,
                                  ),
                                  FlightsField(
                                      controller: fromController,
                                      prefixIcon:
                                          'assets/images/flights_traveller.png',
                                      label: 'select travellers'),
                                  SizedBox(
                                    height: deviceInfo.screenHeight * 0.05,
                                  ),
                                  CustomRoundedButton(
                                    deviceInfo: deviceInfo,
                                    label: 'Search Flights',
                                    backgroundColor: AppColors.appBlue,
                                    onPressed: () {},
                                    textColor: Colors.white,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: deviceInfo.screenHeight * 0.2,
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
