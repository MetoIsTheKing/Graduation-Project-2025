import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_textfield.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/signup_widgets/date_picker.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/airport_text_input.dart';

class TravelerInfoTile extends StatefulWidget {
  const TravelerInfoTile({super.key});

  @override
  State<TravelerInfoTile> createState() => _TravelerInfoTileState();
}

class _TravelerInfoTileState extends State<TravelerInfoTile> {
  Color expandableTitleColor = Colors.white;

  final TextEditingController _fullNameController = TextEditingController();
  final FocusNode _fullNameFocusNode = FocusNode();

  final TextEditingController _birhtDateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final FocusNode _birhtDateFocusNode = FocusNode();

  final TextEditingController _nationalityController = TextEditingController();
  final FocusNode _nationalityFocusNode = FocusNode();

  final TextEditingController _passportNumController = TextEditingController();
  final FocusNode _passportNumFocusNode = FocusNode();

  final TextEditingController _passportExpiryController =
      TextEditingController();
  final FocusNode _passportExpiryFocusNode = FocusNode();

  final TextEditingController _issuingCountryController =
      TextEditingController();
  final FocusNode _issuingCountryFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: deviceInfo.screenHeight * 0.015),
      child: ExpansionTile(
        title: Text(
          'Adult 1:',
          style: TextStyles.medium20(deviceInfo, expandableTitleColor),
        ),
        backgroundColor: Colors.white,
        childrenPadding: EdgeInsets.symmetric(
          horizontal: deviceInfo.screenWidth * 0.05,
          vertical: deviceInfo.screenHeight * 0.012,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            deviceInfo.screenHeight * 0.03,
          ),
          side: BorderSide(
            color: AppColors.appBlue,
            width: deviceInfo.screenHeight * 0.003,
          ),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            deviceInfo.screenHeight * 0.026,
          ),
        ),
        onExpansionChanged: (value) {
          if (value) {
            expandableTitleColor = AppColors.appDarkBlue;
          } else {
            expandableTitleColor = AppColors.appLighterGrey;
          }
          setState(() {});
        },
        leading: Image.asset(
          'assets/images/traveler_icaon.png',
          height: deviceInfo.screenHeight * 0.025,
          color: expandableTitleColor,
        ),
        iconColor: AppColors.appDarkBlue,
        collapsedIconColor: AppColors.appLighterGrey,
        dense: true,
        textColor: AppColors.appDarkBlue,
        collapsedTextColor: AppColors.appDarkBlue,
        collapsedBackgroundColor: AppColors.appBlue,
        expansionAnimationStyle: AnimationStyle(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 300),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Personal details',
                  style:
                      TextStyles.semiBold16(deviceInfo, AppColors.appDarkBlue)),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: deviceInfo.screenHeight * 0.01,
            ),
            child: AuthTextField(
              prefix: 'Full Name',
              hint: 'Enter your full name',
              keyboardType: TextInputType.text,
              controller: _fullNameController,
              focusNode: _fullNameFocusNode,
              nextFocusNode: _birhtDateFocusNode,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: deviceInfo.screenHeight * 0.01,
            ),
            child: CustomDatePickerField(
                deviceInfo: deviceInfo,
                prefix: 'Birth Date',
                hint: 'Choose date',
                selectedDate: selectedDate,
                onDateSelected: (selectedDate) {
                  setState(() {
                    this.selectedDate = selectedDate;
                    _birhtDateController.text =
                        selectedDate.toString().substring(0, 10);
                    log('birhtDate: ${_birhtDateController.text}');
                  });
                }),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: deviceInfo.screenHeight * 0.01,
            ),
            child: AuthTextField(
              prefix: 'Nationality',
              hint: 'Choose nationality',
              keyboardType: TextInputType.text,
              controller: _nationalityController,
              focusNode: _nationalityFocusNode,
              nextFocusNode: _passportNumFocusNode,
            ),
          ),
          SizedBox(
            height: deviceInfo.screenHeight * 0.013,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Travel document',
                  style:
                      TextStyles.semiBold16(deviceInfo, AppColors.appDarkBlue)),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: deviceInfo.screenHeight * 0.01,
            ),
            child: AuthTextField(
              prefix: 'Passport Number',
              hint: '14 number',
              keyboardType: TextInputType.text,
              controller: _passportNumController,
              focusNode: _passportNumFocusNode,
              nextFocusNode: _passportExpiryFocusNode,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: deviceInfo.screenHeight * 0.01,
            ),
            child: AuthTextField(
              prefix: 'Passport Expiry Date',
              hint: 'Choose date',
              keyboardType: TextInputType.text,
              controller: _passportExpiryController,
              focusNode: _passportExpiryFocusNode,
              nextFocusNode: _issuingCountryFocusNode,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: deviceInfo.screenHeight * 0.01,
            ),
            child: AuthTextField(
              prefix: 'Issuing Country',
              hint: 'Choose country',
              keyboardType: TextInputType.text,
              controller: _issuingCountryController,
              focusNode: _issuingCountryFocusNode,
            ),
          ),
        ],
      ),
    );
  }
}
