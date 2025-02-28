import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/core/utils/app_strings.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_app_bar.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_footer.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_textfield.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/divider.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_header.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/signup_widgets/country_picker.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/signup_widgets/date_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? confirmPasswordController;
  TextEditingController? phoneController;
  Country? selectedCountry;
  DateTime? selectedDate;

  bool _passwordObsecurity = true;

  @override
  void dispose() {
    firstNameFocus.dispose();
    lastNameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    phoneFocus.dispose();
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

  void onCountrySelected(Country selectedCountry) {
    setState(() {
      this.selectedCountry = selectedCountry;
    });
  }

  void onDateSelected(DateTime? selectedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo) {
      final fieldsSpacing = deviceInfo.screenHeight * 0.015;
      print('this is code from Signup ---> ${deviceInfo.hashCode}');

      return GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AuthAppBar(
            deviceInfo: deviceInfo,
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
                      title: AppStrings.signupTitle,
                      subtitle: AppStrings.signupSubtitle,
                      deviceInfo: deviceInfo,
                    ),
                    SizedBox(height: deviceInfo.screenHeight * 0.045),
                    Form(
                      child: Column(
                        children: [
                          AuthTextField(
                            deviceInfo: deviceInfo,
                            prefix: 'First name',
                            hint: 'Enter First name',
                            keyboardType: TextInputType.name,
                            focusNode: firstNameFocus,
                            needValidation: true,
                            nextFocusNode: emailFocus,
                            controller: firstNameController,
                          ),
                          SizedBox(height: fieldsSpacing),
                          AuthTextField(
                            deviceInfo: deviceInfo,
                            prefix: 'last name',
                            hint: 'Enter Last name',
                            keyboardType: TextInputType.name,
                            focusNode: lastNameFocus,
                            needValidation: true,
                            nextFocusNode: emailFocus,
                            controller: lastNameController,
                          ),
                          SizedBox(height: fieldsSpacing),
                          AuthTextField(
                            deviceInfo: deviceInfo,
                            prefix: 'Email',
                            hint: 'Enter Email',
                            keyboardType: TextInputType.emailAddress,
                            needValidation: true,
                            focusNode: emailFocus,
                            nextFocusNode: passwordFocus,
                            controller: emailController,
                          ),
                          SizedBox(height: fieldsSpacing),
                          AuthTextField(
                            deviceInfo: deviceInfo,
                            prefix: 'Password',
                            hint: 'Enter Password',
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: _passwordObsecurity,
                            PasswordSuffixIcon: passwordSuffixIcon(),
                            needValidation: true,
                            focusNode: passwordFocus,
                            nextFocusNode: confirmPasswordFocus,
                            controller: passwordController,
                          ),
                          SizedBox(height: fieldsSpacing),
                          AuthTextField(
                            deviceInfo: deviceInfo,
                            prefix: 'Confirm Pass.',
                            hint: 'Confirm Password',
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: _passwordObsecurity,
                            PasswordSuffixIcon: passwordSuffixIcon(),
                            needValidation: true,
                            focusNode: confirmPasswordFocus,
                            controller: confirmPasswordController,
                          ),
                          SizedBox(height: fieldsSpacing),
                          AuthTextField(
                            deviceInfo: deviceInfo,
                            prefix: 'Phone',
                            hint: 'Enter Phone number',
                            keyboardType: TextInputType.phone,
                            needValidation: true,
                            focusNode: phoneFocus,
                            controller: phoneController,
                          ),
                          SizedBox(height: fieldsSpacing),
                          CustomCountryPickerField(
                            deviceInfo: deviceInfo,
                            prefix: 'location',
                            hint: 'Choose Country',
                            onCountrySelected: onCountrySelected,
                            selectedCountry: selectedCountry,
                          ),
                          SizedBox(height: fieldsSpacing),
                          CustomDatePickerField(
                            deviceInfo: deviceInfo,
                            prefix: "Birth Date",
                            hint: "Select Date",
                            onDateSelected: onDateSelected,
                            selectedDate: selectedDate,
                          ),
                          SizedBox(height: fieldsSpacing),
                          CustomRoundedButton(
                            deviceInfo: deviceInfo,
                            label: 'Sign Up',
                            backgroundColor: AppColors.appBlue,
                            onPressed: () {},
                            textColor: Colors.white,
                          ),
                          SizedBox(
                            height: deviceInfo.screenHeight * 0.005,
                          ),
                          CustomDivider(),
                          CustomRoundedButton(
                            deviceInfo: deviceInfo,
                            label: 'Sign Up with Google',
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
                            label: 'Sign Up with Facebook',
                            backgroundColor: AppColors.appBlue,
                            onPressed: () {},
                            textColor: Colors.white,
                            assetIcon: 'assets/images/facebook_icon.png',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: deviceInfo.screenHeight * 0.06,
                    ),
                    AuthFooter(
                      isSignup: true,
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
