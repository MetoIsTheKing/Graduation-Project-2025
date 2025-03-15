import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

class HotelRecomendationCard extends StatelessWidget {
  final String hotelName;
  final String hotelAddress;
  final double hotelRating;
  final String hotelImage;
  const HotelRecomendationCard({
    super.key,
    required this.hotelName,
    required this.hotelAddress,
    required this.hotelRating,
    required this.hotelImage,
  });

  @override
  Widget build(BuildContext context) {
    final deviceInfo = getIt<DeviceInfo>();
    print('has code inside hotel card ${deviceInfo.hashCode}');
    return Container(
      margin: EdgeInsets.only(bottom: deviceInfo.screenHeight * 0.02),
      clipBehavior: Clip.antiAlias,
      constraints: BoxConstraints(
        maxHeight: deviceInfo.screenHeight * 0.15,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color.fromARGB(255, 188, 188, 188),
            spreadRadius: 0.2,
            blurRadius: 10,
            offset: Offset(0, 8),
          ),
        ],
        borderRadius: BorderRadius.circular(deviceInfo.screenWidth * 0.08),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(deviceInfo.screenWidth * 0.08),
            child: Image.asset(
              hotelImage,
              fit: BoxFit.cover,
              width: deviceInfo.screenWidth * 0.3,
              height: deviceInfo.screenWidth * 0.3,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  left: deviceInfo.screenWidth * 0.025,
                  top: deviceInfo.screenHeight * 0.015,
                  bottom: deviceInfo.screenHeight * 0.01),
              child: Padding(
                padding: EdgeInsets.only(right: deviceInfo.screenWidth * 0.045),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotelName,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyles.semiBold16(deviceInfo, AppColors.appBlue),
                    ),
                    Text(
                      hotelAddress,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.regular12(
                          deviceInfo, const Color.fromARGB(255, 104, 104, 104)),
                    ),
                    // SizedBox(
                    //   height: deviceInfo.screenHeight * 0.15 * 0.005,
                    // ),
                    SizedBox(
                      width: deviceInfo.screenWidth * 0.2,
                      child: Row(
                        children: [
                          Icon(Icons.star,
                              color: AppColors.appYellow,
                              size: deviceInfo.screenWidth * 0.04),
                          Text(hotelRating.toString(),
                              style: TextStyles.semiBold12(
                                  deviceInfo, AppColors.appDarkBlue)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
