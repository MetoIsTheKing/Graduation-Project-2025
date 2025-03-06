import 'package:flutter/material.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flights_utils.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/radio_tiles_row.dart';

class FlightsScreen extends StatefulWidget {
  const FlightsScreen({super.key});

  @override
  State<FlightsScreen> createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<FlightsScreen> {
  String? selectedFlightType = 'option1';

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
                      child: Column(
                        children: [
                          SizedBox(
                              width: FlightsUtils.radioTilesRowWidth,
                              child: RadioTilesRow(
                                  selectedFlightType: selectedFlightType,
                                  onSelectedFlightType: onSelectedFlightType)),
                          SizedBox(
                            height: deviceInfo.screenHeight * 0.2,
                          )
                        ],
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
