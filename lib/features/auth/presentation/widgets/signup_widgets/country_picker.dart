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
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  const CustomCountryPickerField({
    super.key,
    required this.deviceInfo,
    required this.prefix,
    required this.hint,
    this.selectedCountry,
    required this.onCountrySelected,
     this.focusNode,
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
        Form.of(context).validate();
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
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
    return FormField<Country>(
      validator: (value) {
        if (selectedCountry == null) {
          return 'Please select a country';
        }
        return null;
      },
      builder: (FormFieldState<Country> state) {
        // Update state when country changes
        if (selectedCountry != null && state.hasError) {
          // Clear error when a country is selected
          WidgetsBinding.instance.addPostFrameCallback((_) {
            state.validate();
          });
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                //focusNode.requestFocus();
                _openCountryPicker(context);
              },
              child: Container(
                height: deviceInfo.screenHeight > deviceInfo.screenWidth
                    ? deviceInfo.screenHeight * 0.06
                    : deviceInfo.screenWidth * 0.079,
                decoration: BoxDecoration(
                  color: AppColors.appLighterGrey,
                  borderRadius:
                      BorderRadius.circular(deviceInfo.screenHeight * 0.055),
                  border: Border.all(
                      // Change border color to red if there's an error
                      color: state.hasError ? Colors.red : AppColors.appGrey,
                      width: 1),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: deviceInfo.screenWidth * 0.04,
                ),
                width: double.infinity,
                child: Row(
                  children: [
                    // Your existing container content
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
            ),
            // Show error message if there is one
            if (state.hasError)
              Padding(
                padding: EdgeInsets.only(
                  left: deviceInfo.screenWidth * 0.04,
                  top: deviceInfo.screenHeight * 0.01,
                ),
                child: Text(
                  state.errorText!,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: deviceInfo.screenWidth * 0.03,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
