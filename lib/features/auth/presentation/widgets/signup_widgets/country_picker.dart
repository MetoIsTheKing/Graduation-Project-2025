import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';

class CustomCountryPickerField extends StatefulWidget {
  final DeviceInfo deviceInfo;
  final String prefix;
  final String hint;
  final Function(Country) onCountrySelected;

  const CustomCountryPickerField({
    super.key,
    required this.deviceInfo,
    required this.prefix,
    required this.hint,
    required this.onCountrySelected,
  });

  @override
  _CustomCountryPickerFieldState createState() =>
      _CustomCountryPickerFieldState();
}

class _CustomCountryPickerFieldState extends State<CustomCountryPickerField> {
  late FocusNode _focusNode;
  late Color _borderColor;
  late Color _fillColor;
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
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
        }
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
        });
        widget.onCountrySelected(country);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openCountryPicker,
      child: Container(
        height: widget.deviceInfo.screenHeight * 0.055,
        decoration: BoxDecoration(
          color: _fillColor,
          borderRadius:
              BorderRadius.circular(widget.deviceInfo.screenHeight * 0.055),
          border: Border.all(color: _borderColor, width: 2),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: widget.deviceInfo.screenWidth * 0.04),
        width: double.infinity,
        child: SizedBox(
          // width: widget.deviceInfo.screenWidth * 0.30,
          child: Row(
            children: [
              SizedBox(
                width: widget.deviceInfo.screenWidth * 0.25,
                child: Row(
                  children: [
                    Text(
                      widget.prefix,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Spacer(),
                    const Text("|",
                        style: TextStyle(color: Colors.grey, fontSize: 20)),
                    const SizedBox(width: 15),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  _selectedCountry != null
                      ? _selectedCountry!.name
                      : widget.hint,
                  style: _selectedCountry != null
                      ? TextStyles.mediumDark18.copyWith(fontSize: 14)
                      : TextStyle(color: Colors.black54, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.deviceInfo.screenWidth * 0.04,
                ),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
