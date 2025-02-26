import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final DeviceInfo deviceInfo;
  final String prefix;
  final String hint;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool needValidation;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  const CustomTextField({
    super.key,
    required this.deviceInfo,
    required this.prefix,
    required this.hint,
    required this.keyboardType,
    this.isPassword = false,
    this.needValidation = false,
    this.focusNode,
    this.nextFocusNode,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isObscured;
  late FocusNode _focusNode;
  late Color _borderColor;
  late Color _fillColor;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    isObscured = widget.isPassword;
    _focusNode = widget.focusNode ?? FocusNode();
    _borderColor = Colors.transparent;
    _fillColor = AppColors.appGrey;

    _focusNode.addListener(() {
      setState(() {
        if (_focusNode.hasFocus) {
          _borderColor = AppColors.appBlue;
          _fillColor = Colors.white;
        } else {
          _borderColor = Colors.transparent;
          _fillColor = AppColors.appGrey;
          _fieldKey.currentState?.validate();
        }
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  String? _validateInput(String? value) {
    if (!widget.needValidation) return null;

    if (value == null || value.isEmpty) {
      return '${widget.prefix} is required';
    }

    if (widget.keyboardType == TextInputType.emailAddress) {
      final emailRegex =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}');
      if (!emailRegex.hasMatch(value)) {
        return 'Enter a valid email';
      }
    }

    if (widget.isPassword) {
      if (value.length < 8) {
        return 'Password must be at least 8 characters';
      }
      if (!RegExp(r'[A-Z]').hasMatch(value)) {
        return 'Must contain at least one uppercase letter';
      }
      if (!RegExp(r'[0-9]').hasMatch(value)) {
        return 'Must contain at least one number';
      }
      if (!RegExp(r'[!@#\\$%^&*(),.?":{}|<>]').hasMatch(value)) {
        return 'Must contain at least one special character';
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _fieldKey,
      focusNode: _focusNode,
      keyboardType: widget.keyboardType,
      obscureText: isObscured,
      validator: _validateInput,
      onChanged: (value) => {},
      textInputAction: widget.nextFocusNode != null
          ? TextInputAction.next
          : TextInputAction.done,
      onFieldSubmitted: (value) {
        if (widget.nextFocusNode != null) {
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
        }
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: _fillColor,
        prefixIcon: Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.deviceInfo.screenWidth * 0.04,
          ),
          alignment: Alignment.centerLeft,
          width: widget.deviceInfo.screenWidth * 0.30,
          child: Row(
            children: [
              Text(
                widget.prefix,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              Spacer(),
              Text(
                '|',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(widget.deviceInfo.screenHeight * 0.055),
          borderSide: BorderSide(color: _borderColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(widget.deviceInfo.screenHeight * 0.055),
          borderSide: BorderSide(color: _borderColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(widget.deviceInfo.screenHeight * 0.055),
          borderSide: BorderSide(color: _borderColor, width: 2),
        ),
        suffixIcon: widget.isPassword
            ? Container(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.deviceInfo.screenWidth * 0.04,
                ),
                child: IconButton(
                  iconSize: widget.deviceInfo.screenWidth * 0.04,
                  icon: Icon(
                    isObscured ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscured = !isObscured;
                    });
                  },
                ),
              )
            : null,
      ),
      style: TextStyles.mediumDark18.copyWith(
        fontSize: 14,
      ),
    );
  }
}
