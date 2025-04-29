import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_app_bar.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key, this.onPressed, required this.Currency});
  final void Function()? onPressed;
  final String Currency;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceInfo.screenWidth * 0.8,
      padding: EdgeInsets.symmetric(
          horizontal: deviceInfo.screenWidth * 0.03,
          vertical: deviceInfo.screenHeight * 0.008),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(deviceInfo.screenHeight * 0.02)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(Currency,
              style: TextStyles.semiBold12(deviceInfo, AppColors.appDarkBlack)),
          SizedBox(
            height: deviceInfo.screenHeight * 0.05,
            // width: deviceInfo.screenWidth * 0.35,
            child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.appBlue),
                child: Text(
                  'Continue',
                  style: TextStyles.semiBold12(deviceInfo, Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
