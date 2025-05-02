import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/curved_appbar.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/total_price_tag.dart';

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
          physics: const ClampingScrollPhysics(),
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
                Accordion(
                  headerBackgroundColor: AppColors.appBlue,
                  headerBorderRadius: deviceInfo.screenHeight * 0.02,
                  headerPadding: EdgeInsets.symmetric(
                    horizontal: deviceInfo.screenWidth * 0.05,
                    vertical: deviceInfo.screenHeight * 0.01,
                  ),
                  headerBackgroundColorOpened: AppColors.appBlue,
                  contentBackgroundColor: Colors.white,
                  contentBorderColor: AppColors.appBlue,
                  contentBorderWidth: 2,
                  contentBorderRadius: deviceInfo.screenHeight * 0.02,
                  contentVerticalPadding: deviceInfo.screenHeight * 0.02,
                  disableScrolling: true,
                  openAndCloseAnimation: true,
                  scaleWhenAnimating: true,
                  sectionOpeningHapticFeedback: SectionHapticFeedback.vibrate,
                  sectionClosingHapticFeedback: SectionHapticFeedback.vibrate,
                  children: [
                    AccordionSection(
                      header: Row(
                        spacing: deviceInfo.screenWidth * 0.02,
                        children: [
                          Image.asset('assets/images/traveler_icaon.png',
                              height: deviceInfo.screenHeight * 0.025),
                          Text(
                            'Adult 1:',
                            style: TextStyles.medium20(
                                deviceInfo, AppColors.appLighterGrey),
                          ),
                        ],
                      ),
                      content: Text('hellow world',
                          style: TextStyles.medium20(
                              deviceInfo, AppColors.appDarkBlue)),
                    ),
                    AccordionSection(
                      header: Row(
                        spacing: deviceInfo.screenWidth * 0.02,
                        children: [
                          Image.asset('assets/images/traveler_icaon.png',
                              height: deviceInfo.screenHeight * 0.025),
                          Text(
                            'Adult 1:',
                            style: TextStyles.medium20(
                                deviceInfo, AppColors.appLighterGrey),
                          ),
                        ],
                      ),
                      content: Text('hellow world',
                          style: TextStyles.medium20(
                              deviceInfo, AppColors.appDarkBlue)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
