import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flight_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flights_travellers_field_widget.dart';

class FlightsClassCardWidget extends StatelessWidget {
  const FlightsClassCardWidget({
    super.key,
    required this.flightModel,
    required this.onSelectedFlightClass,
  });

  final FlightModel flightModel;
  final void Function(String? selectedValue) onSelectedFlightClass;

  @override
  Widget build(BuildContext context) {
    final deviceInfo = getIt<DeviceInfo>();
    return Column(
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
                        'assets/images/travellers_class_icon.png',
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Cabin Class',

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
                      RadioListTile(
                        value: 'economy',
                        groupValue: flightModel.flightClass,
                        onChanged: onSelectedFlightClass,
                        activeColor: AppColors.appBlue,
                        title: Text('Economy'),
                      ),
                      RadioListTile(
                        value: 'premium',
                        groupValue: flightModel.flightClass,
                        onChanged: onSelectedFlightClass,
                        activeColor: AppColors.appBlue,
                        title: Text('Premium Economy'),
                      ),
                      RadioListTile(
                        value: 'business',
                        groupValue: flightModel.flightClass,
                        onChanged: onSelectedFlightClass,
                        activeColor: AppColors.appBlue,
                        title: Text('Business'),
                      ),
                      RadioListTile(
                        value: 'first',
                        groupValue: flightModel.flightClass,
                        onChanged: (String? value) {
                          onSelectedFlightClass(value);
                        },
                        activeColor: AppColors.appBlue,
                        title: Text('First'),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        SizedBox(),
      ],
    );
  }
}
