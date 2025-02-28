import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

class QuickActionButton extends StatelessWidget {
  final double dimension;
  final String icon;
  final String iconlabel;
  final void Function() onPressed;
  const QuickActionButton({
    super.key,
    required this.iconlabel,
    required this.icon,
    required this.onPressed,
    required this.dimension,
  });

  @override
  Widget build(BuildContext context) {
    final deviceInfo = getIt<DeviceInfo>();
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          padding: EdgeInsets.all(deviceInfo.screenWidth * 0.02),
          margin:
              EdgeInsets.symmetric(horizontal: deviceInfo.screenWidth * 0.02),
          width: dimension,
          height: dimension,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(dimension * 0.25),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: null,
                icon: Image.asset(
                  icon,
                  scale: deviceInfo.screenWidth * 0.0045,
                ),
              ),
              Text(
                iconlabel,
                style: TextStyles.semiBold16(deviceInfo, AppColors.appBlue)
                    .copyWith(
                  fontSize: dimension * 0.15,
                ),
              )
            ],
          )),
    );
  }
}
