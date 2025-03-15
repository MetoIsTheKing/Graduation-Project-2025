import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

final deviceInfo = getIt<DeviceInfo>();

class AirportTextInput extends StatelessWidget {
  final String iconPath;
  final TextEditingController airportConteroller;
  final void Function(String)? onChanged;
  const AirportTextInput({
    super.key,
    required this.iconPath,
    required this.airportConteroller, this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    //TODO: refactor text style , handle on change

    return Padding(
      padding: EdgeInsets.symmetric(vertical: deviceInfo.screenHeight * 0.02),
      child: TextField(
        focusNode: focusNode,
        controller: airportConteroller,
        cursorColor: AppColors.appBlue,
        onTapOutside: (event) => focusNode.unfocus(),
        onChanged: onChanged,
        style: TextStyles.medium16(deviceInfo, AppColors.appDarkBlue),
        decoration: InputDecoration(
            hintText: 'Search airport',
            hintStyle: TextStyles.medium16(deviceInfo, Colors.grey),
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
