import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';

import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/core/utils/app_strings.dart';
import 'package:graduation_project_2025/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduation_project_2025/features/auth/presentation/pages/code_verification.dart';
import 'package:graduation_project_2025/features/auth/presentation/pages/login_screen.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_app_bar.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_footer.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_textfield.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/divider.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_header.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/error_toast.dart';
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
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
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
                    ),
                    SizedBox(height: deviceInfo.screenHeight * 0.045),
                    Form(
                      child: Column(
                        children: [
                          AuthTextField(
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
                            controller: confirmPasswordController,
                          ),
                          SizedBox(height: fieldsSpacing),
                          AuthTextField(
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
                          //SizedBox(height: fieldsSpacing),
                          // CustomDatePickerField(
                          //   deviceInfo: deviceInfo,
                          //   prefix: "Birth Date",
                          //   hint: "Select Date",
                          //   onDateSelected: onDateSelected,
                          //   selectedDate: selectedDate,
                          // ),
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
                                print('im from  sign up failed');
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
                                  print('phone : ${phoneController.text}');
                                  print('country : ${selectedCountry?.name}');
                                  final requestBody = {
                                    'firstName': firstNameController.text,
                                    'lastName': lastNameController.text,
                                    'email': emailController.text,
                                    'password': passwordController.text,
                                    'phoneNumber': phoneController.text,
                                    'country': selectedCountry?.name,
                                  };
                                  print('this is requetBody : $requestBody');

                                  context
                                      .read<AuthCubit>()
                                      .register(requestBody);
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
