import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

class TourCard extends StatelessWidget {
  final String tourTitle;
  final String tourSubtitle;
  final double tourRating;
  final double tourPrice;
  // needed to be required
  final void Function()? onTap;
  const TourCard(
      {super.key,
      required this.tourTitle,
      required this.tourSubtitle,
      required this.tourRating,
      required this.tourPrice,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final deviceInfo = getIt<DeviceInfo>();
    print('device in card ${deviceInfo.hashCode}');
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: deviceInfo.screenWidth * 0.02),
        child: Card(
          elevation: deviceInfo.screenWidth * 0.01,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(deviceInfo.screenWidth * 0.04),
          ),
          child: Container(
            color: Colors.white,
            width: deviceInfo.screenWidth * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image with rounded corners
                ClipRRect(
                  child: Image.asset(
                    'assets/images/tour_img_1.png',
                    fit: BoxFit.cover,
                    height: deviceInfo.screenHeight * 0.15,
                    width: double.infinity,
                  ),
                ),
                // Title and subtitle
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: deviceInfo.screenWidth * 0.02,
                      vertical: deviceInfo.screenHeight * 0.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tourTitle,
                          style: TextStyles.semiBold16(
                              deviceInfo, AppColors.appBlue)),
                      Text(tourSubtitle,
                          style: TextStyles.regular12(
                              deviceInfo, AppColors.appDarkGrey)),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: deviceInfo.screenHeight * 0.015),
                        child: Row(
                          children: [
                            Icon(Icons.star,
                                color: AppColors.appYellow,
                                size: deviceInfo.screenWidth * 0.04),
                            Text(tourRating.toString(),
                                style: TextStyles.semiBold12(
                                    deviceInfo, AppColors.appDarkBlue)),
                          ],
                        ),
                      ),
                      const Text(
                        'Starts from',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),

                      // Price and duration row
                      Row(
                        children: [
                          Text(
                            '$tourPrice\$ /pax',
                            style: TextStyles.semiBold16(
                                deviceInfo, AppColors.appBlue),
                          ),
                          const Spacer(),
                          // Container(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: deviceInfo.screenWidth * 0.02,
                          //       vertical: deviceInfo.screenHeight * 0.005),
                          //   decoration: BoxDecoration(
                          //     color: Colors.amber,
                          //     borderRadius: BorderRadius.circular(
                          //         deviceInfo.screenWidth * 0.02),
                          //   ),
                          //   child: Text('3D2N',
                          //       style: TextStyles.semiBold12(
                          //               deviceInfo, AppColors.appDarkBlue)
                          //           .copyWith(
                          //         fontSize: deviceInfo.screenWidth * 0.03,
                          //       )),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Rating and price row
              ],
            ),
          ),
        ),
      ),
    );
  }
}
