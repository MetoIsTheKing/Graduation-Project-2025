import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_app_bar.dart';

import '../../../data/models/flight_details_data_model.dart';

class BaggageSlider extends StatelessWidget {
  const BaggageSlider({
    super.key,
    required this.onTap,
    required this.counter,
    required this.isEconomy,
  });
  final void Function(int selected, double price) onTap;
  final int counter;
  final bool isEconomy;
  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: FlutterCarouselOptions(
        height: deviceInfo.screenHeight * 0.35,
        enlargeCenterPage: true,
        initialPage: counter,
        viewportFraction: .5,
        showIndicator: false,
        // slideIndicator: CircularSlideIndicator(),
        disableCenter: true,
        keepPage: false,
        // padEnds: false,
      ),
      items: [2, 1, 3].map((index) {
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                onTap(
                    index,
                    baggageDetails[isEconomy ? 0 : 1][index - 1]
                        ['extraAmount']);
              },
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                  width: deviceInfo.screenWidth * 0.4,
                  margin: EdgeInsets.symmetric(
                      horizontal: deviceInfo.screenWidth * 0.015),
                  padding: EdgeInsets.symmetric(
                    horizontal: deviceInfo.screenWidth * 0.015,
                    vertical: deviceInfo.screenHeight * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: counter == index
                        ? Border.all(
                            color: AppColors.appYellow,
                            width: deviceInfo.screenWidth * 0.01)
                        : Border.all(
                            color: Colors.white,
                            width: deviceInfo.screenWidth * 0.01),
                    borderRadius: BorderRadius.circular(
                      deviceInfo.screenHeight * 0.02,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          baggageDetails[isEconomy ? 0 : 1][index - 1]['title'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyles.bold34(
                            deviceInfo,
                            AppColors.appDarkBlack,
                          )),
                      SizedBox(
                        height: deviceInfo.screenHeight * 0.01,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ...baggageDetails[isEconomy ? 0 : 1][index - 1]
                                  ['description']
                              .map((e) => _detailsRow(
                                    'assets/images/check_mark.svg',
                                    e,
                                  ))
                              .toList(),
                          _detailsRow(
                            'assets/images/hazard.svg',
                            baggageDetails[isEconomy ? 0 : 1][index - 1]
                                ['extra'],
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        width: double.infinity,
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
                            baggageDetails[isEconomy ? 0 : 1][index - 1]
                                        ['extraAmount'] ==
                                    0
                                ? 'Included'
                                : "${baggageDetails[isEconomy ? 0 : 1][index - 1]['extraAmount'].toString()} USD",
                            style:
                                TextStyles.semiBold12(deviceInfo, Colors.white),
                            textAlign: TextAlign.center,
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
