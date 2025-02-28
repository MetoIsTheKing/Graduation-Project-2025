import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo,constrains) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CustomRoundedButton(
            deviceInfo: deviceInfo,
            label: 'signup',
            backgroundColor: AppColors.appBlue,
            onPressed: () {
              context.pushNamed(Routes.signUp);
            },
            textColor: Colors.white,
          ),
        ),
      );
    });
  }
}
