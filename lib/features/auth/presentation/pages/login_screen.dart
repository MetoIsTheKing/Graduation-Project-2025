import 'package:flutter/material.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/core/utils/app_strings.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/app_bar.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/custom_footer.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/custom_textfield.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/divider.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/title._subtitle_widget.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/custom_signup_button.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/signup_widgets/country_picker.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/signup_widgets/date_picker.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LoginScreen> {
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(deviceInfo: deviceInfo),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: deviceInfo.screenHeight * 0.01,
              horizontal: deviceInfo.screenWidth * 0.04,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleSubtitleWidget(
                    title: AppStrings.loginTitle,
                    subtitle: AppStrings.signupSubtitle,
                    deviceInfo: deviceInfo,
                  ),
                  SizedBox(height: deviceInfo.screenHeight * 0.045),
                  Form(
                    child: Column(
                      children: [
                        CustomTextField(
                          deviceInfo: deviceInfo,
                          prefix: 'Email',
                          hint: 'Enter your Email',
                          keyboardType: TextInputType.emailAddress,
                          needValidation: true,
                          focusNode: emailFocus,
                          nextFocusNode: passwordFocus,
                        ),
                        SizedBox(height: deviceInfo.screenHeight * 0.015),
                        CustomTextField(
                          deviceInfo: deviceInfo,
                          prefix: 'Password',
                          hint: 'Enter your Password',
                          keyboardType: TextInputType.visiblePassword,
                          isPassword: true,
                          needValidation: true,
                          focusNode: passwordFocus,
                        ),
                        SizedBox(height: deviceInfo.screenHeight * 0.015),
                        CustomSignupButton(
                          deviceInfo: deviceInfo,
                          label: 'Log in',
                          backgroundColor: AppColors.appBlue,
                          onPressed: () {},
                          textColor: Colors.white,
                        ),
                        SizedBox(
                          height: deviceInfo.screenHeight * 0.005,
                        ),
                        CustomSignupButton(
                          deviceInfo: deviceInfo,
                          label: 'Forgot Password?',
                          backgroundColor: AppColors.appGrey,
                          onPressed: () {
                            CustomFooter(
                              isSignup: true,
                            );
                          },
                          textColor: AppColors.appDarkBlue,
                        ),
                        SizedBox(height: deviceInfo.screenHeight * 0.015),
                        CustomDivider(),
                        CustomSignupButton(
                          deviceInfo: deviceInfo,
                          label: 'Login with Google',
                          backgroundColor: AppColors.appBlue,
                          onPressed: () {},
                          textColor: Colors.white,
                          assetIcon: 'assets/images/google_icon.png',
                        ),
                        SizedBox(
                          height: deviceInfo.screenHeight * 0.005,
                        ),
                        CustomSignupButton(
                          deviceInfo: deviceInfo,
                          label: 'Login with Facebook',
                          backgroundColor: AppColors.appBlue,
                          onPressed: () {},
                          textColor: Colors.white,
                          assetIcon: 'assets/images/facebook_icon.png',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: deviceInfo.screenHeight * 0.03,
                  ),
                  CustomFooter(
                    isSignup: false,
                  ),
                  SizedBox(
                    height: deviceInfo.screenHeight * 0.06,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
