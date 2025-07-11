import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_app_bar.dart';
import 'package:graduation_project_2025/features/home/flights/data/models/flight_details_data_model.dart';

class TripHeader extends StatelessWidget {
  const TripHeader({super.key, this.oneWay = true, required this.flight});
  final bool oneWay;
  final FlightDetailsDataModel flight;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Center(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: deviceInfo.screenHeight * 0.045),
              width: deviceInfo.screenWidth * 0.4,
              height: deviceInfo.screenHeight * 0.08,
              padding: EdgeInsets.fromLTRB(0, deviceInfo.screenHeight * 0.05, 0,
                  deviceInfo.screenHeight * 0.01),
              decoration: BoxDecoration(
                color: AppColors.appYellow,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(deviceInfo.screenWidth * 0.1),
                  bottomRight: Radius.circular(deviceInfo.screenWidth * 0.1),
                ),
              ),
              child: Text(
                flight.duration,
                style: TextStyles.medium12(
                  deviceInfo,
                  AppColors.appDarkBlack,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: deviceInfo.screenWidth * 0.05,
                vertical: deviceInfo.screenHeight * 0.01),
            height: deviceInfo.screenHeight * 0.09,
            width: deviceInfo.screenWidth * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(deviceInfo.screenHeight * 0.025),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: _textColumn(
                        flight.departureCode, flight.departureDate)),
                SvgPicture.asset(oneWay
                    ? 'assets/images/one_way_trip.svg'
                    : 'assets/images/two_way_trip.svg'),
                Expanded(
                    child: _textColumn(flight.arrivalCode, flight.arrivalDate)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _textColumn(String place, String date) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          place,
          style: TextStyles.semiBold20(deviceInfo, AppColors.appDarkBlack)
              .copyWith(fontSize: deviceInfo.screenWidth * 0.05),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          date,
          style: TextStyles.medium12(deviceInfo, AppColors.appDarkBlack),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
