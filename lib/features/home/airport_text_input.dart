import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

final deviceInfo = getIt<DeviceInfo>();

class AirportTextInput extends StatelessWidget {
  final String iconPath;
  const AirportTextInput({
    super.key,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    //TODO: refactor text style , handle on change
    final TextStyle hintTextStyle = TextStyles.mediumDark16
        .copyWith(fontSize: deviceInfo.screenWidth * 0.035, color: Colors.grey);
    final TextStyle inputTextStyle = TextStyles.mediumDark16
        .copyWith(fontSize: deviceInfo.screenWidth * 0.04, color: Colors.black);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: deviceInfo.screenHeight * 0.02),
      child: TextField(
        style: inputTextStyle,
        decoration: InputDecoration(
            hintText: 'Search airport',
            hintStyle: hintTextStyle,
            filled: true,
            fillColor: const Color.fromARGB(255, 241, 238, 238),
            contentPadding: EdgeInsets.symmetric(
                horizontal: deviceInfo.screenWidth * 0.02,
                vertical: deviceInfo.screenHeight * 0.018),
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(deviceInfo.screenWidth * 0.03),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.appBlue,
                width: 2,
              ),
              borderRadius:
                  BorderRadius.circular(deviceInfo.screenWidth * 0.03),
            ),
            prefixIcon: SvgPicture.asset(
              iconPath,
              width: deviceInfo.screenWidth * 0.03,
              height: deviceInfo.screenHeight * 0.03,
              fit: BoxFit.scaleDown,
            )),
      ),
    );
  }
}
