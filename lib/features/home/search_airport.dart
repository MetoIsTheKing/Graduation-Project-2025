import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/airport_text_input.dart';
import 'package:graduation_project_2025/features/home/explore/presentation/flight_search_results_screen.dart';
import 'package:graduation_project_2025/features/home/search_custom_tile.dart';
import 'package:graduation_project_2025/features/home/curved_appbar.dart';

final deviceInfoo = getIt<DeviceInfo>();

class SearchAirport extends StatefulWidget {
  final String appBarTitle;
  final bool isOrigin;
  final void Function() onBack;
  const SearchAirport(
      {super.key,
      required this.isOrigin,
      required this.appBarTitle,
      required this.onBack});

  @override
  State<SearchAirport> createState() => _SearchAirportState();
}

class _SearchAirportState extends State<SearchAirport> {
  final TextEditingController airportController = TextEditingController();
  @override
  void dispose() {
    airportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context, deviceinfo, constrains) {
        print('device screen width : ${deviceInfoo.screenWidth}');
        print('width inside the info widget : ${deviceinfo.screenWidth}');
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CurvedAppbar(
            backgroundColor: AppColors.appBlue,
            backButtonColor: Colors.white,
            titleWidget: Text(
              widget.appBarTitle,
              style: TextStyles.medium20(deviceinfo, Colors.white),
            ),
            onBack: widget.onBack,
          ),
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: deviceinfo.screenWidth * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AirportTextInput(
                  iconPath: widget.isOrigin
                      ? 'assets/images/plane_up.svg'
                      : 'assets/images/plane_down.svg',
                  airportConteroller: airportController,
                  onChanged: (p0) {
                    //print('changed');
                  },
                ),
                SearchCustomTile(
                  title: "use current location",
                  tileIconPath: 'assets/images/location_pin.svg',
                  tileBorderColor: Colors.grey,
                  tileFillColor: Colors.white,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const FlightSearchResultsScreen()));
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: deviceinfo.screenHeight * 0.02),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: deviceinfo.screenHeight * 0.015),
                  child: SearchCustomTile(
                    title: 'King Salman International Airport',
                    tileIconPath: 'assets/images/airport_icon.svg',
                    tileFillColor: Colors.white,
                    tileBorderColor: AppColors.appBlue,
                    subtitle: Text(
                      'Riyadh , Saudi Arabia',
                      style: TextStyles.medium16(deviceInfoo, Colors.grey)
                          .copyWith(fontSize: deviceinfo.screenHeight * 0.01),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: deviceinfo.screenHeight * 0.015),
                  child: SearchCustomTile(
                    title: 'King Salman International Airport',
                    tileIconPath: 'assets/images/airport_icon.svg',
                    tileFillColor: Colors.white,
                    tileBorderColor: AppColors.appBlue,
                    subtitle: Text(
                      'Riyadh , Saudi Arabia',
                      style: TextStyles.medium16(deviceInfoo, Colors.grey)
                          .copyWith(fontSize: deviceinfo.screenHeight * 0.01),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: deviceinfo.screenHeight * 0.015),
                  child: SearchCustomTile(
                    title: 'King Salman International Airport',
                    tileIconPath: 'assets/images/airport_icon.svg',
                    tileFillColor: Colors.white,
                    tileBorderColor: AppColors.appBlue,
                    subtitle: Text(
                      'Riyadh , Saudi Arabia',
                      style: TextStyles.medium16(deviceInfoo, Colors.grey)
                          .copyWith(fontSize: deviceinfo.screenHeight * 0.01),
                    ),
                  ),
                ),
              ],
            ),
          ))),
        );
      },
    );
  }
}
