import 'package:flutter/material.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/search_custom_tile.dart';

class FlightsTravellersFieldWidget extends StatelessWidget {
  const FlightsTravellersFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
              Text(
                'Adults',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Text(
                'Age(+12)',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Spacer(),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle_outline),
                color: AppColors.appBlue,
                onPressed: () {},
              ),
              Text('1'),
              IconButton(
                icon: Icon(Icons.add_circle_outline),
                color: AppColors.appBlue,
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
