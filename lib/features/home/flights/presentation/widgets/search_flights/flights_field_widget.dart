import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

class FlightsFieldWidget extends StatelessWidget {
  final DeviceInfo deviceInfo;
  final bool isTravellers;
  final String formWidgetLabel;
  final TextEditingController? controller;
  final String prefixIcon;
  final String label;
  final String? Function(String?)? validateField;
  final Function()? onTap;

  const FlightsFieldWidget({
    super.key,
    required this.controller,
    required this.prefixIcon,
    required this.label,
    this.onTap,
    required this.deviceInfo,
    required this.isTravellers,
    required this.formWidgetLabel,
    this.validateField,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: deviceInfo.screenHeight * 0.01),
          child: Text(
            formWidgetLabel,
            style: TextStyles.semiBold18(deviceInfo, AppColors.appBlack)
                .copyWith(
                    fontSize:
                        deviceInfo.screenWidth * 0.03), // Replace this line
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            child: Padding(
              padding: EdgeInsets.only(bottom: deviceInfo.screenHeight * 0.015),
              child: TextFormField(
                  controller: controller,
                  readOnly: true,
                  validator: validateField,
                  style: TextStyles.mediumDark16.copyWith(
                      fontSize: deviceInfo.screenWidth * 0.03,
                      color: Colors.black),
                  decoration: InputDecoration(
                    hintStyle: TextStyles.mediumDark16.copyWith(
                        fontSize: deviceInfo.screenWidth * 0.03,
                        color: Colors.grey),
                    filled: true,
                    fillColor: AppColors.appLighterGrey,
                    hintText: label,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        deviceInfo.screenHeight * 0.02,
                      ),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: deviceInfo.screenWidth * 0.01,
                        vertical: deviceInfo.screenHeight * 0.001,
                      ),
                      child: Image.asset(
                        prefixIcon,
                        fit: BoxFit.scaleDown,
                        scale: deviceInfo.screenWidth * 0.002,
                      ),
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
