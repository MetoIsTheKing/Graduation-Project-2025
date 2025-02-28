import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

class CustomCountryPickerField extends StatelessWidget {
  final DeviceInfo deviceInfo;
  final String prefix;
  final String hint;
  final Country? selectedCountry;
  final Function(Country selectedCountry) onCountrySelected;

  const CustomCountryPickerField({
    super.key,
    required this.deviceInfo,
    required this.prefix,
    required this.hint,
    required this.selectedCountry,
    required this.onCountrySelected,
  });

  void _openCountryPicker(BuildContext context) {
    showCountryPicker(
      searchAutofocus: true,
      context: context,
      showSearch: true,
      showPhoneCode: false,
      onSelect: onCountrySelected,
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: deviceInfo.screenHeight * 0.5,
        textStyle: TextStyles.mediumDark16.copyWith(
          fontSize: deviceInfo.screenWidth * 0.03,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /////////
    final double borderRaduis = deviceInfo.screenHeight * 0.055;
    final TextStyle hintTextStyle = TextStyles.mediumDark16
        .copyWith(fontSize: deviceInfo.screenWidth * 0.03, color: Colors.grey);
    final TextStyle inputTextStyle = TextStyles.mediumDark16
        .copyWith(fontSize: deviceInfo.screenWidth * 0.04, color: Colors.black);
    //////////
    return GestureDetector(
      onTap: () => _openCountryPicker(context),
      child: Container(
        height: deviceInfo.screenHeight > deviceInfo.screenWidth
            ? deviceInfo.screenHeight * 0.06
            : deviceInfo.screenWidth * 0.079,
        decoration: BoxDecoration(
          color: AppColors.appGrey,
          borderRadius: BorderRadius.circular(borderRaduis),
          border: Border.all(color: AppColors.appGrey, width: 2),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: deviceInfo.screenWidth * 0.04,
        ),
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              width: deviceInfo.screenWidth * 0.285,
              child: Row(
                children: [
                  Text(
                    prefix,
                    style: hintTextStyle,
                  ),
                  const Spacer(),
                  Text("|",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: deviceInfo.screenWidth * 0.06)),
                  SizedBox(width: deviceInfo.screenWidth * 0.04),
                ],
              ),
            ),
            Expanded(
              child: Text(
                selectedCountry != null ? selectedCountry!.name : hint,
                style: selectedCountry != null ? inputTextStyle : hintTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              child: const Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
