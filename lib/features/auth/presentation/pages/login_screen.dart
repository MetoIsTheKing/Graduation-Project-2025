import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/config/theming/paddings.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/core/utils/app_strings.dart';
import 'package:graduation_project_2025/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_footer.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_textfield.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/divider.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_header.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/error_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LoginScreen> {
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _passwordObsecurity = true;

  @override
  void dispose() {
    //  nameFocus.dispose();
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
          // appBar: AuthAppBar(
          //   backButtonVisible: false,
          // ),
          body: SafeArea(
            child: Padding(
              padding: Paddings.authMainPagePadding(deviceInfo),
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
                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {
                              if (state is LoginFailed) {
                                errorToast(
                                        title: 'Error',
                                        description: (state).message)
                                    .show(context);
                              } else if (state is LoginSuccess) {
                                successToast(
                                        title: 'Success',
                                        description: 'Login Successful')
                                    .show(context);
                                Future.delayed(const Duration(seconds: 1));
                                print(
                                    'access token from the page --------> : ${state.accessToken}');
                                print(
                                    'refresh token from the page ---------> : ${state.refreshToken}');
                                context.pushReplacementNamed(Routes.mainHome);
                              }
                            },
                            builder: (context, state) {
                              return CustomRoundedButton(
                                isLoading: state is LoginIsLoading,
                                deviceInfo: deviceInfo,
                                label: 'Log in',
                                backgroundColor: AppColors.appBlue,
                                onPressed: () {
                                  print('email : ${emailController.text}');
                                  print(
                                      'password : ${passwordController.text}');
                                  final requestBody = {
                                    'email': emailController.text,
                                    'password': passwordController.text,
                                  };
                                  print('this is requetBody : $requestBody');

                                  context.read<AuthCubit>().login(requestBody);
                                },
                                textColor: Colors.white,
                              );
                            },
                          ),
                          SizedBox(
                            height: deviceInfo.screenHeight * 0.005,
                          ),
                          InkWell(
                            onTap: () {
                              context.pushNamed(Routes.forgetpassword);
                            },
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
