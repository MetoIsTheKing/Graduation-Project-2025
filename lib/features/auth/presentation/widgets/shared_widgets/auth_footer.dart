import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_app_bar.dart';


class AuthFooter extends StatelessWidget {
  final bool isSignup;
  const AuthFooter({super.key, required this.isSignup});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isSignup ? "You have an account? " : 'Don’t have an account? ',
          style: TextStyles.mediumDark16
              .copyWith(fontSize: deviceInfo.screenWidth * 0.03),
        ),
        GestureDetector(
          onTap: () {
            // Make sure that the login screen always comes before the signup screen
            isSignup
                ? context.pushReplacementNamed(Routes.logIn)
                : Navigator.of(context).pushReplacementNamed(Routes.signUp);
          },
          child: Text(isSignup ? "Login" : 'Sign Up',
              style: TextStyles.semiBoldDark32.copyWith(
                  color: AppColors.appBlue,
                  fontSize: deviceInfo.screenWidth * 0.03)),
        ),
      ],
    );
  }
}
