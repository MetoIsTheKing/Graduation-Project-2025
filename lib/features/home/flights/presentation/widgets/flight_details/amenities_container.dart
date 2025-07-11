import 'package:flutter/material.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_app_bar.dart';
import 'package:graduation_project_2025/features/home/flights/data/models/flight_details_data_model.dart';

import '../../../../../../config/theming/text_styles.dart';
import '../../../../../../core/utils/app_colors.dart';

class AmenitiesContainer extends StatelessWidget {
  const AmenitiesContainer({super.key, required this.flight});
  final FlightDetailsDataModel flight;

  @override
  Widget build(BuildContext context) {
    return Container(
      //   height: itemCount * deviceInfo.screenHeight * 0.18,
      clipBehavior: Clip.antiAlias,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: deviceInfo.screenWidth * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(deviceInfo.screenWidth * 0.05),
      ),
      child: Column(
        children: [
          ...flight.amenities.map(
            (amenity) =>
                _amenityItem(amenity.description, amenity.isChargeable),
          ),
        ],
      ),
    );
  }

  Widget _amenityItem(String amenityName, bool isChargeable) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: deviceInfo.screenHeight * 0.01,
        horizontal: deviceInfo.screenWidth * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(amenityName.toLowerCase(),
              style: TextStyles.medium12(deviceInfo, AppColors.appDarkBlack)),
          if (isChargeable)
            Text('Chargeable',
                style: TextStyles.regular12(deviceInfo, AppColors.appRed))
          else
            Text('Included',
                style: TextStyles.regular12(deviceInfo, AppColors.appGreen)),
        ],
      ),
    );
  }
}
