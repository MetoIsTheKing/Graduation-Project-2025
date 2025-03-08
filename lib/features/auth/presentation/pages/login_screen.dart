import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/core/utils/app_strings.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_app_bar.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_footer.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_textfield.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/divider.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LoginScreen> {
  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  final TextEditingController emailController= TextEditingController();
  final TextEditingController passwordController= TextEditingController();

  bool _passwordObsecurity = true;

  @override
  void dispose() {
    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  Widget passwordSuffixIcon() {
    return IconButton(
        icon: Icon(
            _passwordObsecurity ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey),
        onPressed: () {
          setState(() {
            _passwordObsecurity = !_passwordObsecurity;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo, constrains) {
      return GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AuthAppBar(
            backButtonVisible: false,
          ),
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
                    AuthHeader(
                      title: AppStrings.loginTitle,
                      subtitle: AppStrings.signupSubtitle,
                    ),
                    SizedBox(height: deviceInfo.screenHeight * 0.045),
                    Form(
                      child: Column(
                        children: [
                          AuthTextField(
                            prefix: 'Email',
                            hint: 'Enter your Email',
                            keyboardType: TextInputType.emailAddress,
                            needValidation: true,
                            focusNode: emailFocus,
                            nextFocusNode: passwordFocus,
                            controller: emailController,
                          ),
                          SizedBox(height: deviceInfo.screenHeight * 0.015),
                          AuthTextField(
                            prefix: 'Password',
                            hint: 'Enter your Password',
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: _passwordObsecurity,
                            PasswordSuffixIcon: passwordSuffixIcon(),
                            needValidation: true,
                            focusNode: passwordFocus,
                            controller: passwordController,
                          ),
                          SizedBox(height: deviceInfo.screenHeight * 0.015),
                          CustomRoundedButton(
                            deviceInfo: deviceInfo,
                            label: 'Log in',
                            backgroundColor: AppColors.appBlue,
                            onPressed: () {},
                            textColor: Colors.white,
                          ),
                          SizedBox(
                            height: deviceInfo.screenHeight * 0.005,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'Forgot password?',
                              style: TextStyles.regular14(
                                  deviceInfo, AppColors.appDarkBlue),
                            ),
                          ),
                          SizedBox(height: deviceInfo.screenHeight * 0.015),
                          CustomDivider(),
                          CustomRoundedButton(
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
                          CustomRoundedButton(
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
                    AuthFooter(
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
        ),
      );
    });
  }
}
