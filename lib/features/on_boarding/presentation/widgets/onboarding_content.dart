import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingContent extends StatelessWidget {
  final DeviceInfo deviceInfo;
  final int index;
  final String image;
  final String title;
  final String subTitle;
  const OnboardingContent(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.deviceInfo,
      required this.index});

  @override
  Widget build(BuildContext context) {
    if (deviceInfo == getIt<DeviceInfo>()) {
      print('device info is equal');

      print('this is code of di ${getIt<DeviceInfo>().hashCode}');
    }
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: deviceInfo.screenHeight * 0.06,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: deviceInfo.screenHeight * 0.005,
            ),
            child: ClipRRect(
              child: Image.asset(
                image,
                scale: 1 / (deviceInfo.screenHeight * 0.00065),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: deviceInfo.screenHeight * 0.04),
            child: AnimatedSmoothIndicator(
              activeIndex: index,
              curve: Curves.bounceOut,
              count: 3,
              onEnd: () {
                context.pushNamed(Routes.logIn);
              },
              effect: ExpandingDotsEffect(
                dotHeight: deviceInfo.screenHeight * 0.01,
                dotWidth: deviceInfo.screenWidth * 0.03,
                dotColor: Colors.grey,
                activeDotColor: Colors.blue,
              ),
              duration: Duration(milliseconds: 500),
              axisDirection: Axis.horizontal,
              onDotClicked: (index) {
                if (index != 0) {
                  index -= 1;
                }
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.semiBoldDark32
                    .copyWith(fontSize: deviceInfo.screenHeight * 0.032),
              ),
              Text(
                subTitle,
                style: TextStyles.mediumDark16.copyWith(
                  fontSize: deviceInfo.screenHeight * 0.018,
                ),
              ),
            ],
          ),
          //SizedBox(height: deviceInfo.screenHeight * 0.01),
        ],
      ),
    );
  }
}
