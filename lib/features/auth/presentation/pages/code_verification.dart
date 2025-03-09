import 'package:flutter/material.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/core/utils/app_strings.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_app_bar.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_footer.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_header.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/cod_balls.dart';

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
                          CustomRoundedButton(
                            deviceInfo: deviceInfo,
                            label: 'Reset',
                            backgroundColor: AppColors.appBlue,
                            onPressed: () {
                              //clearFields();
                              final String code = _codeController
                                  .map((controller) => controller.text)
                                  .join();
                              print('Verification code: $code');
                              print('email from signup: ${widget.email}');
                            },
                            textColor: Colors.white,
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
