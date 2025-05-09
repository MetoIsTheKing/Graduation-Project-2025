import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flight_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flights_travellers_field_widget.dart';

class FlightsTravellersCardWidget extends StatelessWidget {
  const FlightsTravellersCardWidget(
      {super.key,
      required this.flightModel,
      required this.onAddTraveller,
      required this.onremoveTraveller});

  final FlightModel flightModel;
  final void Function(String travellerType) onAddTraveller;
  final void Function(String travellerType) onremoveTraveller;

  @override
  Widget build(BuildContext context) {
    final deviceInfo = getIt<DeviceInfo>();
    return Padding(
      padding: EdgeInsets.only(
          top: deviceInfo.screenHeight * 0.03,
          bottom: deviceInfo.screenHeight * 0.01),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                deviceInfo.screenHeight * 0.02, // Replace this line
              ),
            ),
            color: Colors.white,
            elevation: 5,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        deviceInfo.screenHeight * 0.02, // Replace this line
                      ),
                      topRight: Radius.circular(
                        deviceInfo.screenHeight * 0.02, // Replace this line
                      ),
                    ),
                    color: AppColors.appBlue,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: deviceInfo.screenWidth * 0.03,
                    vertical: deviceInfo.screenHeight * 0.015,
                  ), // Replace this line
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: deviceInfo.screenWidth * 0.01),
                        child: Image.asset(
                          'assets/images/travellers_card_icon.png',
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Travellers',

                        style: TextStyles.regular16(deviceInfo, Colors.white)
                            .copyWith(
                          fontSize: deviceInfo.screenWidth * 0.03,
                        ),
                        // Replace this line
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: deviceInfo.screenWidth * 0.03,
                      vertical: deviceInfo.screenHeight * 0.02,
                    ), // Replace this line
                    child: Column(
                      children: [
                        FlightsTravellersFieldWidget(
                          isAdult: true,
                          title: 'Adults',
                          subTitle: 'Age(+12)',
                          numberOfTravellers:
                              flightModel.travellers['adults'].toString(),
                          onAddTraveller: () {
                            onAddTraveller('adults');
                          },
                          onRemoveTraveller: () {
                            onremoveTraveller('adults');
                          },
                        ),
                        SizedBox(
                          height: deviceInfo.screenHeight * 0.01,
                        ),
                        FlightsTravellersFieldWidget(
                          isAdult: false,
                          title: 'Children',
                          subTitle: 'Age(2-11)',
                          numberOfTravellers:
                              flightModel.travellers['children'].toString(),
                          onAddTraveller: () {
                            onAddTraveller('children');
                          },
                          onRemoveTraveller: () {
                            onremoveTraveller('children');
                          },
                        ),
                        SizedBox(
                          height: deviceInfo.screenHeight * 0.01,
                        ),
                        FlightsTravellersFieldWidget(
                          isAdult: false,
                          title: 'Infants',
                          subTitle: 'Under 2 years',
                          numberOfTravellers:
                              flightModel.travellers['infants'].toString(),
                          onAddTraveller: () {
                            onAddTraveller('infants');
                          },
                          onRemoveTraveller: () {
                            onremoveTraveller('infants');
                          },
                        ),
                      ],
                    )),
              ],
            ),
          ),
          SizedBox(),
        ],
      ),
    );
  }
}
