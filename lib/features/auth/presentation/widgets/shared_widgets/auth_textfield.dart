import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

class AuthTextField extends StatelessWidget {
  final String prefix;
  final String hint;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool needValidation;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final Widget? PasswordSuffixIcon;
  final TextEditingController controller;

  AuthTextField({
    super.key,
    required this.prefix,
    required this.hint,
    required this.keyboardType,
    this.isPassword = false,
    this.needValidation = false,
    this.focusNode,
    this.nextFocusNode,
    this.PasswordSuffixIcon = null,
    required this.controller,
  }) : assert(!isPassword || PasswordSuffixIcon != null,
            'onToggleObscure is required when isPassword is true');

  // instance of DeviceInfo
  final deviceInfo = getIt<DeviceInfo>();

  String? _validateInput(String? value) {
    if (!needValidation) return null;
    if (value == null || value.isEmpty) return '$prefix is required';

    if (keyboardType == TextInputType.emailAddress) {
      final emailRegex =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    }

    if (keyboardType == TextInputType.visiblePassword) {
      if (value.length < 10) return 'Password must be at least 8 characters';
      if (!RegExp(r'[A-Z]').hasMatch(value)) {
        return 'Must contain at least one uppercase letter';
      }
      if (!RegExp(r'[0-9]').hasMatch(value)) {
        return 'Must contain at least one number';
      }
      if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
        return 'Must contain at least one special character';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    //////////
    final double borderRaduis = deviceInfo.screenHeight * 0.055;
    final TextStyle hintTextStyle = TextStyles.mediumDark16
        .copyWith(fontSize: deviceInfo.screenWidth * 0.03, color: Colors.grey);
    final TextStyle inputTextStyle = TextStyles.mediumDark16.copyWith(
        fontSize: deviceInfo.screenWidth * 0.035, color: Colors.black);
    /////////
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: isPassword,
      validator: _validateInput,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction:
          nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
      onFieldSubmitted: (value) {
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.appGrey,
        prefixIcon: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: deviceInfo.screenWidth * 0.04),
          child: SizedBox(
            width: deviceInfo.screenWidth * 0.25,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  prefix,
                  style: hintTextStyle,
                ),
                const Spacer(),
                Text(
                  '|',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: deviceInfo.screenWidth * 0.06),
                ),
              ],
            ),
          ),
        ),
        hintText: hint,
        hintStyle: hintTextStyle,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRaduis),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRaduis),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRaduis),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRaduis),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRaduis),
          borderSide: const BorderSide(color: AppColors.appBlue, width: 2),
        ),
        suffixIcon: PasswordSuffixIcon,
      ),
      style: inputTextStyle,
    );
  }
}
