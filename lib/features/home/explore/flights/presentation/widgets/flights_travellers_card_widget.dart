import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flights_travellers_field_widget.dart';

class FlightsTravellersCardWidget extends StatelessWidget {
  const FlightsTravellersCardWidget({super.key});

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
                      FlightsTravellersFieldWidget(),
                      SizedBox(
                        height: deviceInfo.screenHeight * 0.01,
                      ),
                      FlightsTravellersFieldWidget(),
                      SizedBox(
                        height: deviceInfo.screenHeight * 0.01,
                      ),
                      FlightsTravellersFieldWidget(),
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
