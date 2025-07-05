import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/paddings.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_app_bar.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_header.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_textfield.dart';
import 'package:graduation_project_2025/features/home/profile/presentation/manager/profile_cubit.dart';
import 'package:graduation_project_2025/features/home/profile/presentation/manager/profile_state.dart';
import 'package:graduation_project_2025/core/shared_components/error_toast.dart';

class ChangePasswordScreen extends StatefulWidget {
  final bool isReset;
  const ChangePasswordScreen({super.key, this.isReset = false});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final currentController = TextEditingController();
  final newController = TextEditingController();
  final confirmController = TextEditingController();

  final currentFocus = FocusNode();
  final newFocus = FocusNode();
  final confirmFocus = FocusNode();

  bool _passwordObsecurity = true;

  @override
  void dispose() {
    currentController.dispose();
    newController.dispose();
    confirmController.dispose();
    currentFocus.dispose();
    newFocus.dispose();
    confirmFocus.dispose();
    super.dispose();
  }

  Widget passwordSuffixIcon() {
    return IconButton(
      icon: Icon(
        _passwordObsecurity ? Icons.visibility_off : Icons.visibility,
        color: Colors.grey,
      ),
      onPressed: () {
        setState(() {
          _passwordObsecurity = !_passwordObsecurity;
        });
      },
    );
  }

  void _onSubmit(BuildContext ctx) {
    if (!_formKey.currentState!.validate()) return;

    final cubit = ctx.read<ProfileCubit>();
    final newPassword = newController.text.trim();
    final confirmPassword = confirmController.text.trim();

    if (newPassword != confirmPassword) {
      errorToast(title: 'Error', description: 'Passwords do not match')
          .show(context);
      return;
    }

    if (widget.isReset) {
      final resetCode = currentController.text.trim();
      cubit.resetPassword(resetCode, newPassword);
    } else {
      final currentPassword = currentController.text.trim();
      cubit.changePassword(currentPassword, newPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context, deviceInfo, constraints) {
        final fieldSpacing = deviceInfo.screenHeight * 0.015;

        return BlocProvider(
          create: (_) => getIt<ProfileCubit>(),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AuthAppBar(
              backButtonVisible: true,
              onPressed: () => Navigator.pop(context),
            ),
            body: SafeArea(
              child: Padding(
                padding: Paddings.authMainPagePadding(deviceInfo),
                child: BlocConsumer<ProfileCubit, UserState>(
                  listener: (context, state) {
                    if (state is UserSuccess) {
                      successToast(title: 'Success', description: state.message)
                          .show(context);
                      Navigator.pop(context);
                    } else if (state is UserError) {
                      errorToast(title: 'Error', description: state.message)
                          .show(context);
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AuthHeader(
                            title: widget.isReset
                                ? 'Reset Password'
                                : 'Change Password',
                            subtitle: '',
                          ),
                          SizedBox(height: fieldSpacing),
                          AuthTextField(
                            prefix: widget.isReset ? 'Code' : 'Current',
                            hint: widget.isReset
                                ? 'Enter Reset Code'
                                : 'Enter Current Password',
                            keyboardType: TextInputType.visiblePassword,
                            controller: currentController,
                            isPassword: !widget.isReset && _passwordObsecurity,
                            focusNode: currentFocus,
                            nextFocusNode: newFocus,
                            PasswordSuffixIcon:
                                widget.isReset ? null : passwordSuffixIcon(),
                          ),
                          SizedBox(height: fieldSpacing),
                          AuthTextField(
                            prefix: 'New',
                            hint: 'Enter New Password',
                            keyboardType: TextInputType.visiblePassword,
                            controller: newController,
                            isPassword: _passwordObsecurity,
                            focusNode: newFocus,
                            nextFocusNode: confirmFocus,
                            needValidation: true,
                            PasswordSuffixIcon: passwordSuffixIcon(),
                          ),
                          SizedBox(height: fieldSpacing),
                          AuthTextField(
                            prefix: 'Confirm',
                            hint: 'Confirm Password',
                            keyboardType: TextInputType.visiblePassword,
                            controller: confirmController,
                            isPassword: _passwordObsecurity,
                            focusNode: confirmFocus,
                            needValidation: true,
                            isConfirmPassword: true,
                            passwordController: newController,
                            PasswordSuffixIcon: passwordSuffixIcon(),
                          ),
                          SizedBox(height: fieldSpacing),
                          CustomRoundedButton(
                            deviceInfo: deviceInfo,
                            label: widget.isReset ? 'Reset' : 'Change',
                            backgroundColor: AppColors.appBlue,
                            textColor: Colors.white,
                            isLoading: state is UserLoading,
                            onPressed: () => _onSubmit(context),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
