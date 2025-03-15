import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/core/utils/app_strings.dart';
import 'package:graduation_project_2025/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_app_bar.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_footer.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_header.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/cod_balls.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/error_toast.dart';

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

  @override
  void dispose() {
    for (var node in _codeFocus) {
      node.dispose();
    }
    for (var codeController in _codeController) {
      codeController.dispose();
    }
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
                    SizedBox(height: fieldsSpacing),
                    Form(
                      child: Column(
                        children: [
                          SizedBox(height: fieldsSpacing),
                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {
                              if (state is VerificationStates) {
                                if (!state.isSuccess && !state.isLoading) {
                                  errorToast(
                                    title: 'Error',
                                    description: state.error!,
                                  ).show(context);
                                } else if (state.isSuccess &&
                                    !state.isLoading) {
                                  successToast(
                                          title: 'Success',
                                          description:
                                              'your account has been verified')
                                      .show(context);
                                  Future.delayed(const Duration(seconds: 1));
                                  context.pushReplacementNamed(Routes.logIn);
                                }
                              }
                            },
                            builder: (context, state) {
                              return CustomRoundedButton(
                                deviceInfo: deviceInfo,
                                isLoading: state is VerificationStates &&
                                    state.isLoading,
                                label: 'Verify',
                                backgroundColor: AppColors.appBlue,
                                onPressed: () {
                                  //clearFields();
                                  final String code = _codeController
                                      .map((controller) => controller.text)
                                      .join();
                                  //final emailTest = '3laahanylol@gmail.com';
                                  //final codeTest = '2R4FQ';

                                  context.read<AuthCubit>().verifyEmail(
                                      {'email': widget.email, 'code': code});
                                  print('Verification code: $code');
                                  print('email from signup: ${widget.email}');
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
