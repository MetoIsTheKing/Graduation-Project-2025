// Accordion(
//                   headerBackgroundColor: AppColors.appBlue,
//                   headerBorderRadius: deviceInfo.screenHeight * 0.02,
//                   headerPadding: EdgeInsets.symmetric(
//                     horizontal: deviceInfo.screenWidth * 0.05,
//                     vertical: deviceInfo.screenHeight * 0.01,
//                   ),
//                   headerBackgroundColorOpened: AppColors.appBlue,
//                   contentBackgroundColor: Colors.white,
//                   contentBorderColor: AppColors.appBlue,
//                   contentBorderWidth: 2,
//                   contentBorderRadius: deviceInfo.screenHeight * 0.02,
//                   contentVerticalPadding: deviceInfo.screenHeight * 0.02,
//                   disableScrolling: true,
//                   openAndCloseAnimation: false,
//                   scaleWhenAnimating: true,
//                   sectionOpeningHapticFeedback: SectionHapticFeedback.vibrate,
//                   sectionClosingHapticFeedback: SectionHapticFeedback.vibrate,
//                   children: [
//                     AccordionSection(
//                       header: Row(
//                         spacing: deviceInfo.screenWidth * 0.02,
//                         children: [
//                           Image.asset('assets/images/traveler_icaon.png',
//                               height: deviceInfo.screenHeight * 0.025),
//                           Text(
//                             'Adult 1:',
//                             style: TextStyles.medium20(
//                                 deviceInfo, AppColors.appLighterGrey),
//                           ),
//                         ],
//                       ),
//                       content: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           GestureDetector(
//                             onTap: () {},
//                             child: AuthTextField(
//                                 prefix: 'Full Name',
//                                 hint: 'Enter your full name',
//                                 keyboardType: TextInputType.text,
//                                 controller: TextEditingController()),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),