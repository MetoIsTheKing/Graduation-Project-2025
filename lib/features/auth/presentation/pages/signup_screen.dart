import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/theming/paddings.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';

import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/core/utils/app_strings.dart';
import 'package:graduation_project_2025/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduation_project_2025/features/auth/presentation/pages/code_verification.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_app_bar.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_footer.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_textfield.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/divider.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_header.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/error_toast.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/signup_widgets/auth_phone_widget.dart';
import 'package:intl_phone_field/countries.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FocusNode firstNameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();
  final FocusNode birthFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  Country selectedCountry = countries.firstWhere(
    (country) =>
        country.code == 'EG', // Change 'US' to your desired country code
    orElse: () => countries.first, // Fallback to the first country if not found
  );
  final _formKey = GlobalKey<FormState>();

  bool _passwordObsecurity = true;
  // bool enablePhoneField = false;

  @override
  void dispose() {
    firstNameFocus.dispose();
    lastNameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    phoneFocus.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();

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

  void onCountryChanged(Country country) {
    setState(() {
      selectedCountry = country;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo, constrains) {
      final fieldsSpacing = deviceInfo.screenHeight * 0.015;
      print('this is code from Signup ---> ${deviceInfo.hashCode}');

      return GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AuthAppBar(
            backButtonVisible: true,
            onPressed: () => context.pop(),
          ),
          body: SafeArea(
            bottom: false,
            child: Padding(
              padding: Paddings.authMainPagePadding(deviceInfo),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthHeader(
                      title: AppStrings.signupTitle,
                      subtitle: AppStrings.signupSubtitle,
                    ),
                    SizedBox(height: deviceInfo.screenHeight * 0.045),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AuthTextField(
                            prefix: 'First name',
                            hint: 'Enter First name',
                            keyboardType: TextInputType.name,
                            focusNode: firstNameFocus,
                            needValidation: true,
                            nextFocusNode: lastNameFocus,
                            controller: firstNameController,
                          ),
                          SizedBox(height: fieldsSpacing),
                          AuthTextField(
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
                            prefix: 'Confirm Pass.',
                            hint: 'Confirm Password',
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: _passwordObsecurity,
                            PasswordSuffixIcon: passwordSuffixIcon(),
                            needValidation: true,
                            focusNode: confirmPasswordFocus,
                            nextFocusNode: birthFocus,
                            controller: confirmPasswordController,
                            isConfirmPassword: true,
                            passwordController: passwordController,
                          ),
                          SizedBox(height: fieldsSpacing),

                          AuthTextField(
                            prefix: 'Birth Date',
                            hint: 'Enter your birth date',
                            keyboardType: TextInputType.text,
                            needValidation: true,
                            focusNode: birthFocus,
                            nextFocusNode: phoneFocus,
                            controller: birthController,
                            isConfirmPassword: false,
                          ),
                          SizedBox(height: fieldsSpacing),
                          // CustomCountryPickerField(
                          //   deviceInfo: deviceInfo,
                          //   prefix: 'location',
                          //   hint: 'Choose Country',
                          //   onCountrySelected: onCountrySelected,
                          //   selectedCountry: selectedCountry,
                          //   nextFocusNode: phoneFocus,
                          //   focusNode: countryFocus,
                          // ),
                          // SizedBox(height: fieldsSpacing),
                          // AuthTextField(
                          //   prefix: 'Phone',
                          //   hint: 'Enter Phone number',
                          //   keyboardType: TextInputType.phone,
                          //   needValidation: true,
                          //   focusNode: phoneFocus,
                          //   controller: phoneController,
                          //   isPhoneField: true,
                          //   enablePhoneField: enablePhoneField,
                          // ),
                          AuthPhoneWidget(
                            focusNode: phoneFocus,
                            controller: phoneController,
                            onCountryChanged: onCountryChanged,
                            initialCountry: selectedCountry,
                          ),
                          SizedBox(height: fieldsSpacing),
                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {
                              if (state is SignUpEmailAlreadyExists) {
                                print('im from  email already exists');
                                errorToast(
                                        title: 'Error',
                                        description: (state).message)
                                    .show(context);
                              } else if (state is SignUpFailed) {
                                print('im from sign up failed');
                                errorToast(
                                        title: 'Error',
                                        description: (state).message)
                                    .show(context);
                              } else if (state is SignUpSuccess) {
                                successToast(
                                        title: 'Success',
                                        description:
                                            'your account has been registered')
                                    .show(context);
                                Future.delayed(const Duration(seconds: 1));
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => CodeVerification(
                                    email: emailController.text,
                                  ),
                                ));
                              }
                            },
                            builder: (context, state) {
                              return CustomRoundedButton(
                                isLoading: state is SignUpIsLoading,
                                deviceInfo: deviceInfo,
                                label: 'Sign Up',
                                backgroundColor: AppColors.appBlue,
                                onPressed: () {
                                  //context.pushReplacementNamed(Routes.mainHome);
                                  print(
                                      'first name : ${firstNameController.text}');
                                  print(
                                      'last name : ${lastNameController.text}');
                                  print('email : ${emailController.text}');
                                  print(
                                      'password : ${passwordController.text}');
                                  print(
                                      'confirm password : ${confirmPasswordController.text}');
                                  print(
                                      'Phone : +${selectedCountry.dialCode}${phoneController.text}');
                                  print('Country : ${selectedCountry.name}');
                                  final requestBody = {
                                    'firstName': firstNameController.text,
                                    'lastName': lastNameController.text,
                                    'email': emailController.text,
                                    'password': passwordController.text,
                                    'country': selectedCountry.name,
                                    'birthdate': birthController.text,
                                    'phoneNumber':
                                        "+${selectedCountry.dialCode}${phoneController.text}",
                                  };
                                  print('this is requetBody : $requestBody');

                                  if (_formKey.currentState!.validate() &&
                                      phoneController.text.isNotEmpty) {
                                    context
                                        .read<AuthCubit>()
                                        .register(requestBody);
                                  }

                                  //email :
                                  //code    :
                                  // errorToast(
                                  //   title: 'Error',
                                  //   description: 'Something went wrong',
                                  // ).show(context);
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //   builder: (context) => CodeVerification(
                                  //     email: emailController.text,
                                  //   ),
                                  // ));
                                  // context.read<AuthCubit>().register(requestBody);
                                  // if (context.read<AuthCubit>().state
                                  //     is AuthSignUpSuccess) {
                                  //   Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => CodeVerification(
                                  //       email: emailController.text,
                                  //     ),
                                  //   ));
                                  // }
                                },
                                textColor: Colors.white,
                              );
                            },
                          ),
                          SizedBox(
                            height: deviceInfo.screenHeight * 0.005,
                          ),
                          CustomDivider(),
                          CustomRoundedButton(
                            deviceInfo: deviceInfo,
                            label: 'Sign Up with Google',
                            backgroundColor: AppColors.appBlue,
                            onPressed: () {
                              dev.log(selectedCountry.name);
                            },
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

// class FixedTextController extends TextEditingController {
//   final int fixedTextLength;

//   FixedTextController({required String? fixedText})
//       : fixedTextLength = fixedText == null ? 0 : fixedText.length,
//         super(text: fixedText);

//   @override
//   set value(TextEditingValue newValue) {
//     // Ensure cursor stays after the fixed text
//     if (newValue.selection.start < fixedTextLength) {
//       newValue = newValue.copyWith(
//         selection: TextSelection.collapsed(offset: fixedTextLength),
//       );
//     }
//     super.value = newValue;
//   }
// }
