import 'package:flutter/material.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_app_bar.dart';

class AmenitiesContainer extends StatelessWidget {
  const AmenitiesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //   height: itemCount * deviceInfo.screenHeight * 0.18,
      clipBehavior: Clip.antiAlias,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: deviceInfo.screenWidth * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(deviceInfo.screenWidth * 0.05),
      ),
    );
  }
}
