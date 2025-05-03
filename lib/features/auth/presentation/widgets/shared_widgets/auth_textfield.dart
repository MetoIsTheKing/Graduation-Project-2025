// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final bool isConfirmPassword;
  final FocusNode? focusNode;
  final TextEditingController? passwordController;
  final FocusNode? nextFocusNode;
  final Widget? PasswordSuffixIcon;
  final List<TextInputFormatter>? inputFormatters;
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
    this.PasswordSuffixIcon,
    required this.controller,
    this.isConfirmPassword = false,
    this.passwordController,
    this.inputFormatters,
  }) {
    // if (fixedPhoneCode != null &&
    //     controller.text.startsWith(fixedPhoneCode!)) {
    //   controller.text =
    //       fixedPhoneCode!; // Ensure it always starts with the fixed code
    //   controller.selection = TextSelection.fromPosition(
    //     TextPosition(offset: controller.text.length),
    //   );
    // }
  }

  // instance of DeviceInfo
  final deviceInfo = getIt<DeviceInfo>();

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) return '$prefix is required';
    if (!needValidation) return null;
    if (keyboardType == TextInputType.emailAddress) {
      final emailRegex =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    }

    if (isConfirmPassword && passwordController != null) {
      if (passwordController!.text != value) {
        return '''Password doesn't match''';
      }
    }
    if (keyboardType == TextInputType.number) {
      if (int.parse(value) < 18) {
        return "Age must be greater than 18";
      } else if (value.length > 2) {
        return "Age must be less than 3 digits";
      } else if (value.isEmpty) {
        return "Age is required";
      }
    }

    if (keyboardType == TextInputType.visiblePassword && !isConfirmPassword) {
      if (value.length < 10) return 'Password must be at least 10 characters';
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
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
        errorStyle: hintTextStyle.copyWith(color: Colors.red),
        filled: true,
        fillColor: AppColors.appLighterGrey,
        prefixIcon: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: deviceInfo.screenWidth * 0.04),
          child: SizedBox(
            width: deviceInfo.screenWidth * 0.25,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: deviceInfo.screenWidth * 0.22,
                  child: Text(
                    prefix,
                    style: hintTextStyle,
                  ),
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
      inputFormatters: inputFormatters,
      cursorColor: AppColors.appBlue,
    );
  }
}

// class MinLengthTextInputFormatter extends TextInputFormatter {
//   final int minLength;

//   MinLengthTextInputFormatter(this.minLength);

//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     if (newValue.text.length < minLength) {
//       return oldValue; // Prevent deletion if text is below minLength
//     }
//     return newValue;
//   }
// }
