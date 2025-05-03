import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/curved_appbar.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/total_price_tag.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/traveler_info_tile.dart';

class BookingApplicationScreen extends StatelessWidget {
  const BookingApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo, constraints) {
      return Scaffold(
        appBar: CurvedAppbar(
            onBack: () => context.pop(),
            backgroundColor: AppColors.appBlue,
            titleWidget: Text(
              'Enter travelers details',
              style: TextStyles.medium20(deviceInfo, Colors.white),
            ),
            backButtonColor: Colors.white),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: deviceInfo.screenWidth * 0.05,
              vertical: deviceInfo.screenHeight * 0.03),
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TotalPriceTag(
                  deviceInfo: deviceInfo,
                  totalPrice: '1000',
                  onTapSummary: () {
                    print('view summary');
                  },
                ),
                TravelerInfoTile(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
