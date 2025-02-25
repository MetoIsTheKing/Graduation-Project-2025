import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:intl/intl.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';

class CustomDatePickerField extends StatefulWidget {
  final DeviceInfo deviceInfo;
  final String prefix;
  final String hint;
  final Function(DateTime) onDateSelected;

  const CustomDatePickerField({
    super.key,
    required this.deviceInfo,
    required this.prefix,
    required this.hint,
    required this.onDateSelected,
  });

  @override
  _CustomDatePickerFieldState createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
  late FocusNode _focusNode;
  late Color _borderColor;
  late Color _fillColor;
  DateTime? _selectedDate;

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

  void _openDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
      widget.onDateSelected(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openDatePicker,
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
        child: Row(
          children: [
            SizedBox(
              width: widget.deviceInfo.screenWidth * 0.25,
              child: Row(
                children: [
                  SizedBox(
                    child: Text(
                      widget.prefix,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                  const Spacer(),
                  const Text("|",
                      style: TextStyle(color: Colors.grey, fontSize: 20)),
                  const SizedBox(width: 15),
                ],
              ),
            ),
            Expanded(
              child: Text(
                _selectedDate != null
                    ? DateFormat("MMMM d, yyyy").format(_selectedDate!)
                    : widget.hint,
                style: _selectedDate != null
                    ? TextStyles.semiBoldDark32
                        .copyWith(color: AppColors.appBlue, fontSize: 18)
                    : TextStyle(color: Colors.black54, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: widget.deviceInfo.screenWidth * 0.04,
              ),
              child: Icon(
                Icons.calendar_today,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
