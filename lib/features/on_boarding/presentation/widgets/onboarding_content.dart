import 'package:flutter/material.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: deviceInfo.screenHeight * 0.005,
          ),
          child: ClipRRect(
            child: Image.asset(image, width: deviceInfo.screenHeight * 0.5),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: deviceInfo.screenHeight * 0.05),
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyles.semiBoldDark32
                  .copyWith(fontSize: deviceInfo.screenWidth * 0.07),
            ),
            Text(
              subTitle,
              style: TextStyles.mediumDark16.copyWith(
                fontSize: deviceInfo.screenWidth * 0.035,
              ),
            ),
          ],
        ),
        //SizedBox(height: deviceInfo.screenHeight * 0.1),
      ],
    );
  }
}
