import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

class EmptyListWidget extends StatelessWidget {
  final DeviceInfo deviceInfo;
  final int selected;
  final String sectionName;

  const EmptyListWidget({
    super.key,
    required this.deviceInfo,
    required this.selected,
    required this.sectionName,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'You haven’t booked any $sectionName yet',
            style: TextStyles.semiBold16(deviceInfo, AppColors.appBlue),
          ),
          Image.asset('assets/images/empty_list.png',
              height: deviceInfo.screenHeight * 0.4),
          SizedBox(
            height: deviceInfo.screenHeight * 0.05,
            width: deviceInfo.screenWidth * 0.6,
            child: CustomRoundedButton(
              deviceInfo: deviceInfo,
              label: 'Book It',
              backgroundColor: AppColors.appYellow,
              onPressed: () {},
              textColor: AppColors.appDarkBlue,
              assetIcon: (selected == 0)
                  ? 'assets/images/flight_icon.png'
                  : 'assets/images/hotel_icon.png',
              imageColor: AppColors.appDarkBlue,
            ),
          )
        ],
      ),
    );
  }
}
