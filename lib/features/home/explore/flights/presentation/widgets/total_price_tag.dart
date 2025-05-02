import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

class TotalPriceTag extends StatelessWidget {
  final DeviceInfo deviceInfo;
  final String totalPrice;
  final void Function()? onTapSummary;
  const TotalPriceTag({
    super.key,
    this.onTapSummary,
    required this.totalPrice,
    required this.deviceInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: deviceInfo.screenHeight * 0.01),
      padding: EdgeInsets.symmetric(
          horizontal: deviceInfo.screenWidth * 0.05,
          vertical: deviceInfo.screenHeight * 0.02),
      height: deviceInfo.screenHeight * 0.12,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color.fromARGB(255, 207, 207, 207),
            blurRadius: deviceInfo.screenHeight * 0.002,
            offset: Offset(
                deviceInfo.screenWidth * 0.01, deviceInfo.screenHeight * 0.006),
          ),
        ],
        color: AppColors.appGrey,
        borderRadius: BorderRadius.circular(deviceInfo.screenHeight * 0.02),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Price :',
                  style:
                      TextStyles.medium12(deviceInfo, AppColors.appDarkBlue)),
              Text(
                '$totalPrice USD',
                style: TextStyles.semiBold20(deviceInfo, AppColors.appDarkBlue),
              ),
            ],
          ),
          InkWell(
            onTap: onTapSummary,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: deviceInfo.screenWidth * 0.012,
                  vertical: deviceInfo.screenHeight * 0.005),
              alignment: Alignment.center,
              width: deviceInfo.screenWidth * 0.32,
              height: deviceInfo.screenHeight * 0.0425,
              decoration: BoxDecoration(
                color: AppColors.appYellow,
                borderRadius:
                    BorderRadius.circular(deviceInfo.screenHeight * 0.02),
              ),
              child: Text(
                'view summary',
                style: TextStyles.semiBold12(deviceInfo, AppColors.appDarkBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
