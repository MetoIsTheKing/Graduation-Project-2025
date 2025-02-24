import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

class CustomFooter extends StatelessWidget {
  final bool isSignup;
  const CustomFooter({super.key, required this.isSignup});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isSignup ? "You have an account? " : 'Don’t have an account? ',
          style: TextStyles.mediumDark16.copyWith(fontSize: 14), // Normal text
        ),
        GestureDetector(
          onTap: () {
            isSignup
                ? context.pushNamed(Routes.logIn)
                : context.pushNamed(Routes.signUp);
          },
          child: Text(isSignup ? "Login" : 'Sign Up',
              style: TextStyles.semiBoldDark32
                  .copyWith(color: AppColors.appBlue, fontSize: 14)),
        ),
      ],
    );
  }
}
