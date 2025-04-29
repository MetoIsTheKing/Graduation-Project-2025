import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_app_bar.dart';

class BaggageSlider extends StatelessWidget {
  const BaggageSlider({super.key, required this.onTap, required this.counter});
  final void Function(int selected) onTap;
  final int counter;
  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: FlutterCarouselOptions(
        height: deviceInfo.screenHeight * 0.3,
        enlargeCenterPage: true,
        initialPage: 1,
        viewportFraction: .5,
        showIndicator: false,
        // slideIndicator: CircularSlideIndicator(),
        disableCenter: true,
      ),
      items: [1, 2, 3].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                onTap(i);
              },
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                  width: deviceInfo.screenWidth * 0.4,
                  margin: EdgeInsets.symmetric(
                      horizontal: deviceInfo.screenWidth * 0.015),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: counter == i
                        ? Border.all(
                            color: AppColors.appYellow,
                            width: deviceInfo.screenWidth * 0.01)
                        : null,
                    borderRadius: BorderRadius.circular(
                      deviceInfo.screenHeight * 0.02,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '22',
                              style: TextStyles.bold75(
                                  deviceInfo, AppColors.appDarkBlack),
                            ),
                            TextSpan(
                              text: ' KG',
                              style: TextStyles.bold34(
                                  deviceInfo, AppColors.appDarkBlack),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: deviceInfo.screenHeight * 0.01,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: deviceInfo.screenWidth * 0.015),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _detailsRow('assets/images/check_mark.svg',
                                '7 kg cabin baggage'),
                            _detailsRow('assets/images/check_mark.svg',
                                '7 kg checked baggage'),
                            _detailsRow(
                                'assets/images/hazard.svg', 'Not Refundable'),
                            _detailsRow(
                                'assets/images/hazard.svg', 'Not Changeable'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: deviceInfo.screenHeight * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.appBlue,
                          borderRadius: BorderRadius.circular(
                            deviceInfo.screenHeight * 0.03,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: deviceInfo.screenHeight * 0.01,
                              horizontal: deviceInfo.screenWidth * 0.02),
                          child: Text(
                            '+ 2500 USD',
                            style:
                                TextStyles.semiBold12(deviceInfo, Colors.white),
                          ),
                        ),
                      )
                    ],
                  )),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _detailsRow(String assetPath, String text) {
    return Row(
      children: [
        SvgPicture.asset(
          assetPath,
        ),
        SizedBox(
          width: deviceInfo.screenWidth * 0.01,
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyles.medium12(deviceInfo, AppColors.appDarkBlack)
                .copyWith(
              fontSize: deviceInfo.screenHeight * 0.013,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: deviceInfo.screenHeight * 0.025,
        )
      ],
    );
  }
}
