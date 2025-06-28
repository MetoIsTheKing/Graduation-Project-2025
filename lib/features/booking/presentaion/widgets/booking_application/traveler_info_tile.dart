import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_textfield.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/signup_widgets/country_picker.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/signup_widgets/date_picker.dart';
import 'package:graduation_project_2025/features/booking/data/models/traveler_info_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/search_airport/airport_text_input.dart';
import 'package:country_picker/country_picker.dart';

class TravelerInfoTile extends StatefulWidget {
  final TravelerInfoUiModel travelerInfoModel;
  final Function(TravelerInfoUiModel) onDataChanged;
  const TravelerInfoTile(
      {super.key,
      required this.travelerInfoModel,
      required this.onDataChanged});

  @override
  State<TravelerInfoTile> createState() => _TravelerInfoTileState();
}

class _TravelerInfoTileState extends State<TravelerInfoTile> {
  Color expandableTitleColor = Colors.white;

  final TextEditingController _firstNameController = TextEditingController();
  final FocusNode _firstNameFocusNode = FocusNode();
  final TextEditingController _lastNameController = TextEditingController();
  final FocusNode _lastNameFocusNode = FocusNode();

  final TextEditingController _birhtDateController = TextEditingController();
  DateTime selectedBirthDate = DateTime.now();
  final FocusNode _birhtDateFocusNode = FocusNode();

  final TextEditingController _nationalityController = TextEditingController();
  final FocusNode _nationalityFocusNode = FocusNode();
  Country? selectedNationalitytCountry;

  final TextEditingController _passportNumController = TextEditingController();
  final FocusNode _passportNumFocusNode = FocusNode();

  final TextEditingController _passportExpiryController =
      TextEditingController();
  DateTime selectedExpiryDate = DateTime.now();
  final FocusNode _passportExpiryFocusNode = FocusNode();

  final TextEditingController _issuingCountryController =
      TextEditingController();
  final FocusNode _issuingCountryFocusNode = FocusNode();
  Country? selectedIssuingCountry;

  @override
  void initState() {
    selectedBirthDate = DateTime.now();
    _birhtDateController.text = selectedBirthDate.toString().substring(0, 10);
    widget.travelerInfoModel.birthDate = _birhtDateController.text;
    selectedExpiryDate = DateTime.now().add(const Duration(days: 365 * 5));
    _passportExpiryController.text =
        selectedExpiryDate.toString().substring(0, 10);
    widget.travelerInfoModel.passportExpiryDate =
        _passportExpiryController.text;
    widget.onDataChanged(widget.travelerInfoModel);

    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birhtDateController.dispose();
    _nationalityController.dispose();
    _passportNumController.dispose();
    _passportExpiryController.dispose();
    _issuingCountryController.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _birhtDateFocusNode.dispose();
    _nationalityFocusNode.dispose();
    _passportNumFocusNode.dispose();
    _passportExpiryFocusNode.dispose();
    _issuingCountryFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: deviceInfo.screenHeight * 0.015),
      child: ExpansionTile(
        title: Text(
          widget.travelerInfoModel.travelerType,
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
              prefix: 'First Name',
              hint: 'Enter your first name',
              keyboardType: TextInputType.name,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^[a-zA-Z\s]+$'),
                ),
                FilteringTextInputFormatter.deny(
                  RegExp(r'^[0-9]+$'),
                ),
              ],
              controller: _firstNameController,
              focusNode: _firstNameFocusNode,
              nextFocusNode: _lastNameFocusNode,
              needValidation: true,
              onChanged: (value) {
                widget.travelerInfoModel.firstName = _firstNameController.text;
                widget.onDataChanged(widget.travelerInfoModel);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: deviceInfo.screenHeight * 0.01,
            ),
            child: AuthTextField(
              prefix: 'Last Name',
              hint: 'Enter your last name',
              keyboardType: TextInputType.name,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^[a-zA-Z\s]+$'),
                ),
                FilteringTextInputFormatter.deny(
                  RegExp(r'^[0-9]+$'),
                ),
              ],
              controller: _lastNameController,
              focusNode: _lastNameFocusNode,
              nextFocusNode: _birhtDateFocusNode,
              needValidation: true,
              onChanged: (value) {
                widget.travelerInfoModel.lastName = _lastNameController.text;
                widget.onDataChanged(widget.travelerInfoModel);
              },
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
                selectedDate: selectedBirthDate,
                onDateSelected: (selectedDate) {
                  setState(() {
                    selectedBirthDate = selectedDate;
                    _birhtDateController.text =
                        selectedDate.toString().substring(0, 10);
                    widget.travelerInfoModel.birthDate =
                        _birhtDateController.text;
                    widget.onDataChanged(widget.travelerInfoModel);

                    log('birhtDate: ${_birhtDateController.text}');
                  });
                }),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: deviceInfo.screenHeight * 0.01,
            ),
            child: CustomCountryPickerField(
              deviceInfo: deviceInfo,
              focusNode: _nationalityFocusNode,
              nextFocusNode: _passportNumFocusNode,
              selectedCountry: selectedNationalitytCountry,
              hint: 'Select nationality',
              onCountrySelected: (selectedCountry) {
                setState(() {
                  selectedNationalitytCountry = selectedCountry;
                  _nationalityController.text = selectedCountry.name;
                  widget.travelerInfoModel.nationality =
                      _nationalityController.text;
                  widget.onDataChanged(widget.travelerInfoModel);

                  log('selectedCountry: ${_nationalityController.text}');
                });
              },
              prefix: "Nationality",
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
                hint: 'Enter passport number',
                keyboardType: TextInputType.text,
                controller: _passportNumController,
                focusNode: _passportNumFocusNode,
                nextFocusNode: _passportExpiryFocusNode,
                needValidation: true,
                onChanged: (value) {
                  widget.travelerInfoModel.passportNumber =
                      _passportNumController.text;
                  widget.onDataChanged(widget.travelerInfoModel);
                }),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: deviceInfo.screenHeight * 0.01,
            ),
            child: CustomDatePickerField(
                deviceInfo: deviceInfo,
                prefix: 'Expiry Date',
                hint: 'Choose date',
                selectedDate: selectedExpiryDate,
                onDateSelected: (selectedDate) {
                  setState(() {
                    selectedExpiryDate = selectedDate;
                    _passportExpiryController.text =
                        selectedDate.toString().substring(0, 10);
                    widget.travelerInfoModel.passportExpiryDate =
                        _passportExpiryController.text;
                    widget.onDataChanged(widget.travelerInfoModel);

                    log('expiryDate: ${_passportExpiryController.text}');
                  });
                }),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: deviceInfo.screenHeight * 0.01,
            ),
            child: CustomCountryPickerField(
              deviceInfo: deviceInfo,
              focusNode: _issuingCountryFocusNode,
              selectedCountry: selectedIssuingCountry,
              hint: 'Select issuing country',
              onCountrySelected: (selectedCountry) {
                setState(() {
                  selectedIssuingCountry = selectedCountry;
                  _issuingCountryController.text = selectedCountry.name;
                  widget.travelerInfoModel.issuingCountry =
                      _issuingCountryController.text;
                  widget.onDataChanged(widget.travelerInfoModel);

                  log('selectedIssuingCountry: ${_issuingCountryController.text}');
                });
              },
              prefix: "Issuing Country",
            ),
          ),
        ],
      ),
    );
  }
}
