import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/shared_functions/debouncer.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/core/utils/app_strings.dart';
import 'package:graduation_project_2025/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_app_bar.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_header.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/cod_balls.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/error_toast.dart';
import 'package:otp_resend_timer/otp_resend_timer.dart';

class CodeVerification extends StatefulWidget {
  final String email;
  const CodeVerification({super.key, required this.email});

  @override
  State<CodeVerification> createState() => _CodeVerificationState();
}

class _CodeVerificationState extends State<CodeVerification> {
  final List<FocusNode> _codeFocus = List.generate(5, (index) => FocusNode());
  final List<TextEditingController> _codeController =
      List.generate(5, (index) => TextEditingController());
  final timerController = OtpResendTimerController(initialTime: 60);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final debouncer = Debouncer(milliseconds: 600);
  @override
  void dispose() {
    for (var node in _codeFocus) {
      node.dispose();
    }
    for (var codeController in _codeController) {
      codeController.dispose();
    }
    timerController.dispose();
    super.dispose();
  }

  void clearFields() {
    for (var codeController in _codeController) {
      codeController.clear();
    }
    FocusScope.of(context).unfocus();
  }

  void _nextField(String value, int index) {
    if (value.isNotEmpty && index < _codeFocus.length - 1) {
      FocusScope.of(context).requestFocus(_codeFocus[index + 1]);
    }
  }

  // void emptyFieldsHandling(String codeInput) {
  //   debouncer.run(() {
  //     if (codeInput.isEmpty) {
  //       errorToast(
  //         title: 'Error',
  //         description: 'Please enter the verification code',
  //       ).show(context);
  //       return;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo, constrains) {
      final fieldsSpacing = deviceInfo.screenHeight * 0.015;

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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AuthHeader(
                        title: AppStrings.codeVerificationTitle,
                        subtitle: AppStrings.forgetpasswordSubtitle,
                      ),
                      SizedBox(height: deviceInfo.screenHeight * 0.045),
                      SizedBox(
                        height: deviceInfo.screenHeight * 0.08,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return CodBalls(
                              controller: _codeController[index],
                              focusNode: _codeFocus[index],
                              onchang: (value) => _nextField(value, index),
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: fieldsSpacing * 2),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is VerificationStates) {
                            if (!state.isSuccess && !state.isLoading) {
                              errorToast(
                                title: 'Error',
                                description: state.error!,
                              ).show(context);
                            } else if (state.isSuccess && !state.isLoading) {
                              successToast(
                                      title: 'Success',
                                      description:
                                          'your account has been verified')
                                  .show(context);
                              Future.delayed(const Duration(seconds: 2), () {
                                if (context.mounted) {
                                  context.pushReplacementNamed(Routes.logIn);
                                }
                              });
                            }
                          } else if (state is ResendVerificationStates) {
                            if (!state.isSuccess &&
                                !state.isLoading &&
                                state.error != null) {
                              errorToast(
                                      title: 'Error', description: state.error!)
                                  .show(context);
                            } else if (state.isSuccess) {
                              successToast(
                                      title: 'Success',
                                      description: 'Verification code resent')
                                  .show(context);
                            }
                          }
                        },
                        builder: (context, state) {
                          return IntrinsicHeight(
                            child: Column(
                              children: [
                                CustomRoundedButton(
                                  deviceInfo: deviceInfo,
                                  isLoading: state is VerificationStates &&
                                      state.isLoading,
                                  label: 'Verify',
                                  backgroundColor: AppColors.appBlue,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    final String code = _codeController
                                        .map((controller) => controller.text)
                                        .join();
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthCubit>().verifyEmail({
                                        'email': widget.email,
                                        'code': code
                                      });

                                      print('Verification code: $code');
                                      print(
                                          'email from signup: ${widget.email}');
                                      //clearFields();
                                    }
                                    //emptyFieldsHandling(code);

                                    //final emailTest = '3laahanylol@gmail.com';
                                    //final codeTest = '2R4FQ';
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: deviceInfo.screenHeight * 0.02),
                                  child: OtpResendTimer(
                                    controller: timerController,

                                    timerMessage: "Resend in",
                                    readyMessage: "Ready to resend!",
                                    resendMessage: "RESEND",

                                    // Styles
                                    timerMessageStyle: TextStyles.semiBold16(
                                        deviceInfo, AppColors.appBlue),
                                    readyMessageStyle: TextStyles.medium12(
                                        deviceInfo, AppColors.appDarkBlue),
                                    resendMessageStyle: TextStyles.semiBold16(
                                        deviceInfo, AppColors.appBlue),
                                    resendMessageDisabledStyle:
                                        TextStyles.medium12(
                                            deviceInfo, Colors.grey),

                                    // Callbacks
                                    onStart: () => print("Timer started"),
                                    onFinish: () => print("Timer finished"),
                                    onResendClicked: () {
                                      log('resend clicked');
                                      context
                                          .read<AuthCubit>()
                                          .resendVerification(
                                              {'email': widget.email});
                                    },

                                    // Auto-start the timer
                                    autoStart: true,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: deviceInfo.screenHeight * 0.28,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
