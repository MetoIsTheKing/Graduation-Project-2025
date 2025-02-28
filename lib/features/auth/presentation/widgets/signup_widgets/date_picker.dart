import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:intl/intl.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';

class CustomDatePickerField extends StatelessWidget {
  final DeviceInfo deviceInfo;
  final String prefix;
  final String hint;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const CustomDatePickerField({
    super.key,
    required this.deviceInfo,
    required this.prefix,
    required this.hint,
    required this.selectedDate,
    required this.onDateSelected,
  });

  void _openDatePicker(BuildContext context) async {
    DateTime? pickedDate;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: deviceInfo.screenHeight * 0.5,
                child: CalendarDatePicker(
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  onDateChanged: (date) {
                    pickedDate = date;
                  },
                ),
              ),
              const SizedBox(height: 10),
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel",
                        style: TextStyle(color: Colors.red)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (pickedDate != null) {
                        onDateSelected(pickedDate!);
                      }
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appBlue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Confirm"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    /////////
    final double borderRaduis = deviceInfo.screenHeight * 0.055;
    final TextStyle hintTextStyle = TextStyles.mediumDark16
        .copyWith(fontSize: deviceInfo.screenWidth * 0.03, color: Colors.grey);
    final TextStyle inputTextStyle = TextStyles.mediumDark16.copyWith(
        fontSize: deviceInfo.screenWidth * 0.04, color: AppColors.appBlue);
    //////////
    return GestureDetector(
      onTap: () => _openDatePicker(context),
      child: Container(
        height: deviceInfo.screenHeight > deviceInfo.screenWidth
            ? deviceInfo.screenHeight * 0.06
            : deviceInfo.screenWidth * 0.079,
        decoration: BoxDecoration(
          color: AppColors.appGrey,
          borderRadius: BorderRadius.circular(borderRaduis),
          border: Border.all(color: AppColors.appGrey, width: 2),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: deviceInfo.screenWidth * 0.04,
        ),
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              width: deviceInfo.screenWidth * 0.285,
              child: Row(
                children: [
                  Text(
                    prefix,
                    style: hintTextStyle,
                  ),
                  const Spacer(),
                  Text("|",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: deviceInfo.screenWidth * 0.06)),
                  SizedBox(width: deviceInfo.screenWidth * 0.04),
                ],
              ),
            ),
            Expanded(
              child: Text(
                selectedDate != null
                    ? DateFormat("dd/MM/yyyy").format(selectedDate!)
                    : hint,
                style: selectedDate != null ? inputTextStyle : hintTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              child: const Icon(
                Icons.calendar_month,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
