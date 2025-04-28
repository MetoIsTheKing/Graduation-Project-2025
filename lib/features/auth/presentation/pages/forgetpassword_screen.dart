import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
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
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_header.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/error_toast.dart';

class ForgetpasswordScreen extends StatefulWidget {
  const ForgetpasswordScreen({super.key});

  @override
  State<ForgetpasswordScreen> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<ForgetpasswordScreen> {
  FocusNode emailFocus = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo, constrains) {
      final fieldsSpacing = deviceInfo.screenHeight * 0.015;
      print('this is code from Forgetpassword ---> ${deviceInfo.hashCode}');

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
              padding: Paddings.authMainPagePadding(deviceInfo),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthHeader(
                      title: AppStrings.forgetpasswordTitle,
                      subtitle: AppStrings.forgetpasswordSubtitle,
                    ),
                    SizedBox(height: deviceInfo.screenHeight * 0.045),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: fieldsSpacing),
                          AuthTextField(
                            prefix: 'Email',
                            hint: 'Enter Email',
                            keyboardType: TextInputType.emailAddress,
                            needValidation: true,
                            focusNode: emailFocus,
                            //  nextFocusNode: passwordFocus,
                            controller: emailController,
                          ),
                          SizedBox(height: fieldsSpacing),
                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {
                              if (state is RequestPassResetFailed) {
                                errorToast(
                                        title: 'Error',
                                        description: (state).message)
                                    .show(context);
                              } else if (state is RequestPassResetSuccess) {
                                successToast(
                                        title: 'Success',
                                        description:
                                            'A code has been sent to your email')
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
                                isLoading: state is RequestPassResetIsLoading,
                                deviceInfo: deviceInfo,
                                label: 'Send',
                                backgroundColor: AppColors.appBlue,
                                onPressed: () {
                                  //context.pushReplacementNamed(Routes.mainHome);
                                  print('email : ${emailController.text}');

                                  final requestBody = {
                                    'email': emailController.text,
                                  };
                                  print('this is requetBody : $requestBody');

                                  if (_formKey.currentState!.validate()) {
                                    context
                                        .read<AuthCubit>()
                                        .requestResetPassword(requestBody);
                                  }
                                },
                                textColor: Colors.white,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: deviceInfo.screenHeight * 0.32,
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
