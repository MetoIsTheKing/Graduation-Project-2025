import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

class FlightsTravellersFieldWidget extends StatelessWidget {
  const FlightsTravellersFieldWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.numberOfTravellers,
      required this.onAddTraveller,
      required this.onRemoveTraveller});

  final String title;
  final String subTitle;
  final String numberOfTravellers;
  final void Function() onAddTraveller;
  final void Function() onRemoveTraveller;

  @override
  Widget build(BuildContext context) {
    final deviceInfo = getIt<DeviceInfo>(); // Get device info here

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: deviceInfo.screenWidth * 0.03,
          vertical: deviceInfo.screenHeight * 0.001),
      decoration: BoxDecoration(
        color: AppColors.appLighterGrey,
        borderRadius: BorderRadius.circular(deviceInfo.screenHeight * 0.02),
      ),
      height: deviceInfo.screenHeight * 0.07,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: TextStyles.medium16(deviceInfo, Colors.black)),
              Text(subTitle,
                  style: TextStyles.medium12(deviceInfo, Colors.grey)),
            ],
          ),
          Spacer(),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle_outline),
                color: AppColors.appBlue,
                onPressed: numberOfTravellers == '0' ? null : onRemoveTraveller,
              ),
              Text(
                numberOfTravellers,
                style: TextStyles.medium16(deviceInfo, Colors.black),
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline),
                color: AppColors.appBlue,
                onPressed: onAddTraveller,
              ),
            ],
          )
        ],
      ),
    );
  }
}
