import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class AuthPhoneWidget extends StatelessWidget {
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextEditingController controller;
  final void Function(Country country) onCountryChanged;
  final Country initialCountry;
  AuthPhoneWidget({
    super.key,
    this.focusNode,
    this.nextFocusNode,
    required this.controller,
    required this.onCountryChanged,
    required this.initialCountry,
  });
  final deviceInfo = getIt<DeviceInfo>();

  String? _validateInput(PhoneNumber? value) {
    if (value == null || value.completeNumber.isEmpty) {
      return 'Phone is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    //////////
    final double borderRaduis = deviceInfo.screenHeight * 0.055;
    final TextStyle hintTextStyle = TextStyles.mediumDark16
        .copyWith(fontSize: deviceInfo.screenWidth * 0.03, color: Colors.grey);
    final TextStyle inputTextStyle = TextStyles.mediumDark16.copyWith(
        fontSize: deviceInfo.screenWidth * 0.035, color: Colors.black);
    final InputDecoration inputDecoration = InputDecoration(
      hintStyle: hintTextStyle,
      fillColor: AppColors.appLighterGrey,
      errorStyle: hintTextStyle.copyWith(color: Colors.red),
      counterStyle: hintTextStyle,
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide(),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRaduis),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRaduis),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRaduis),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRaduis),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRaduis),
        borderSide: const BorderSide(color: AppColors.appBlue, width: 2),
      ),
    );
    /////////
    return IntlPhoneField(
      validator: _validateInput,
      controller: controller,
      focusNode: focusNode,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      keyboardType: TextInputType.number,
      textInputAction:
          nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
      flagsButtonPadding: EdgeInsets.symmetric(
        horizontal: deviceInfo.screenWidth * 0.028,
      ),
      cursorColor: AppColors.appBlue,
      style: inputTextStyle,
      //autovalidateMode: AutovalidateMode.onUserInteraction,
      dropdownIcon:
          Icon(Icons.arrow_drop_down, size: deviceInfo.screenWidth * 0.07),
      dropdownTextStyle: inputTextStyle,

      pickerDialogStyle: PickerDialogStyle(
        backgroundColor: Colors.white,
        countryCodeStyle: inputTextStyle,
        countryNameStyle: inputTextStyle,
        searchFieldCursorColor: AppColors.appBlue,
        searchFieldPadding: EdgeInsets.fromLTRB(
          deviceInfo.screenWidth * 0.02,
          deviceInfo.screenHeight * 0.02,
          deviceInfo.screenWidth * 0.02,
          0,
        ),
        searchFieldInputDecoration:
            inputDecoration.copyWith(hintText: 'Search Country'),
      ),
      decoration: inputDecoration.copyWith(hintText: 'Enter phone Number'),
      initialCountryCode: initialCountry.code,
      onChanged: (value) {},
      onCountryChanged: (value) {
        dev.log(
            'Selected Country: ${value.name}, Target Length: ${value.maxLength}');
        onCountryChanged(value);
      },
    );
  }
}
