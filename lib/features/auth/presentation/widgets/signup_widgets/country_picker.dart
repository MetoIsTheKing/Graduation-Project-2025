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
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;

  const CustomCountryPickerField({
    super.key,
    required this.deviceInfo,
    required this.prefix,
    required this.hint,
    this.selectedCountry,
    required this.onCountrySelected,
    required this.focusNode,
    this.nextFocusNode,
  });

  void _openCountryPicker(BuildContext context) {
    showCountryPicker(
      searchAutofocus: false,
      context: context,
      showSearch: true,
      showPhoneCode: false,
      onSelect: (Country country) {
        onCountrySelected(country);
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
      },
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: deviceInfo.screenHeight * 0.5,
        textStyle: TextStyles.mediumDark16.copyWith(
          fontSize: deviceInfo.screenWidth * 0.03,
          color: Colors.black,
        ),
        backgroundColor: AppColors.appLighterGrey,
        //       borderRadius: BorderRadius.circular(deviceInfo.screenHeight * 0.055),
        inputDecoration: InputDecoration(
          filled: true,
          fillColor: AppColors.appLighterGrey,
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(deviceInfo.screenHeight * 0.055),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(deviceInfo.screenHeight * 0.055),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(deviceInfo.screenHeight * 0.055),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          hintText: "Search country...",
          hintStyle: TextStyles.mediumDark16.copyWith(
              fontSize: deviceInfo.screenWidth * 0.03, color: Colors.grey),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.requestFocus();
        _openCountryPicker(context);
      },
      child: Container(
        height: deviceInfo.screenHeight > deviceInfo.screenWidth
            ? deviceInfo.screenHeight * 0.06
            : deviceInfo.screenWidth * 0.079,
        decoration: BoxDecoration(
          color: AppColors.appLighterGrey,
          borderRadius: BorderRadius.circular(deviceInfo.screenHeight * 0.055),
          border: Border.all(color: AppColors.appGrey, width: 2),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: deviceInfo.screenWidth * 0.04,
        ),
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              width: deviceInfo.screenWidth * 0.32,
              child: Row(
                children: [
                  Text(prefix,
                      style: TextStyles.mediumDark16.copyWith(
                          fontSize: deviceInfo.screenWidth * 0.03,
                          color: Colors.grey)),
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
                style: selectedCountry != null
                    ? TextStyles.mediumDark16.copyWith(
                        fontSize: deviceInfo.screenWidth * 0.035,
                        color: Colors.black)
                    : TextStyles.mediumDark16.copyWith(
                        fontSize: deviceInfo.screenWidth * 0.03,
                        color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
