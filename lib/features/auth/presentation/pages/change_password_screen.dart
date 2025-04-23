import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/paddings.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_app_bar.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_header.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_textfield.dart';

class ChangePasswordScreen extends StatefulWidget {
  final bool isReset;
  const ChangePasswordScreen({super.key, this.isReset = false});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController currentController = TextEditingController();
  final TextEditingController newController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  final FocusNode currentFocus = FocusNode();
  final FocusNode newFocus = FocusNode();
  final FocusNode confirmFocus = FocusNode();
  bool _passwordObsecurity = true;
  final _formKey = GlobalKey<FormState>();

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

  void onChangePasswordPressed() {
    dev.log('Change Password');
  }

  void onResetPasswordPressed() {
    dev.log('Reset Password');
  }

  @override
  void dispose() {
    currentFocus.dispose();
    newFocus.dispose();
    confirmFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fieldsSpacing = deviceInfo.screenHeight * 0.015;

    return InfoWidget(builder: (context, deviceInfo, constrains) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AuthAppBar(
              backButtonVisible: true,
              onPressed: () {
                Navigator.pop(context);
              }),
          body: GestureDetector(
            onTap: FocusScope.of(context).unfocus,
            child: Padding(
              padding: Paddings.authMainPagePadding(deviceInfo),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthHeader(
                    title:
                        widget.isReset ? 'Reset Password' : 'Change Password',
                    subtitle: '',
                  ),
                  SizedBox(height: deviceInfo.screenHeight * 0.005),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        widget.isReset
                            ? SizedBox()
                            : AuthTextField(
                                prefix: 'Current',
                                hint: 'Enter current Password',
                                keyboardType: TextInputType.visiblePassword,
                                controller: currentController,
                                isPassword: _passwordObsecurity,
                                focusNode: currentFocus,
                                nextFocusNode: newFocus,
                                PasswordSuffixIcon: passwordSuffixIcon(),
                              ),
                        SizedBox(
                          height: widget.isReset ? 0 : fieldsSpacing,
                        ),
                        AuthTextField(
                          prefix: 'New',
                          hint: 'Enter new password',
                          keyboardType: TextInputType.visiblePassword,
                          controller: newController,
                          isPassword: _passwordObsecurity,
                          focusNode: newFocus,
                          nextFocusNode: confirmFocus,
                          needValidation: true,
                          PasswordSuffixIcon: passwordSuffixIcon(),
                        ),
                        SizedBox(
                          height: fieldsSpacing,
                        ),
                        AuthTextField(
                          prefix: 'Confirm',
                          hint: 'Confirm password',
                          keyboardType: TextInputType.visiblePassword,
                          controller: confirmController,
                          isPassword: _passwordObsecurity,
                          focusNode: confirmFocus,
                          needValidation: true,
                          PasswordSuffixIcon: passwordSuffixIcon(),
                          isConfirmPassword: true,
                          passwordController: newController,
                        ),
                        SizedBox(
                          height: fieldsSpacing,
                        ),
                        CustomRoundedButton(
                          deviceInfo: deviceInfo,
                          label: widget.isReset ? 'Reset' : 'Change',
                          backgroundColor: AppColors.appBlue,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              widget.isReset
                                  ? onResetPasswordPressed()
                                  : onChangePasswordPressed();
                            }
                          },
                          textColor: Colors.white,
                        )
                      ],
                    ),
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
