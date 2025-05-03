import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomDatePickerField extends StatefulWidget {
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

  @override
  State<CustomDatePickerField> createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
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
                height: widget.deviceInfo.screenHeight * 0.5,
                child: TableCalendar(
                  firstDay: DateTime(1900),
                  lastDay: DateTime(2100),
                  focusedDay: widget.selectedDate ?? DateTime.now(),
                  selectedDayPredicate: (day) {
                    return isSameDay(widget.selectedDate, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      pickedDate = selectedDay;
                    });
                  },
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: AppColors.appDarkBlue, width: 2),
                    ),
                    todayTextStyle: TextStyle(color: AppColors.appDarkBlue),
                    selectedDecoration: BoxDecoration(
                      color: AppColors.appBlue,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: TextStyle(color: Colors.white),
                  ),
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
                        widget.onDateSelected(pickedDate!);
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
    final double borderRaduis = widget.deviceInfo.screenHeight * 0.055;
    final TextStyle hintTextStyle = TextStyles.mediumDark16.copyWith(
        fontSize: widget.deviceInfo.screenWidth * 0.03, color: Colors.grey);
    final TextStyle inputTextStyle = TextStyles.mediumDark16.copyWith(
        fontSize: widget.deviceInfo.screenWidth * 0.03,
        color: AppColors.appDarkBlue);
    //////////
    return GestureDetector(
      onTap: () => _openDatePicker(context),
      child: Container(
        height: widget.deviceInfo.screenHeight > widget.deviceInfo.screenWidth
            ? widget.deviceInfo.screenHeight * 0.06
            : widget.deviceInfo.screenWidth * 0.079,
        decoration: BoxDecoration(
          color: AppColors.appLighterGrey,
          borderRadius: BorderRadius.circular(borderRaduis),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: widget.deviceInfo.screenWidth * 0.04,
        ),
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              width: widget.deviceInfo.screenWidth * 0.285,
              child: Row(
                children: [
                  Text(
                    widget.prefix,
                    style: hintTextStyle,
                  ),
                  const Spacer(),
                  Text("|",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: widget.deviceInfo.screenWidth * 0.06)),
                  SizedBox(width: widget.deviceInfo.screenWidth * 0.04),
                ],
              ),
            ),
            Expanded(
              child: Text(
                widget.selectedDate != null
                    ? widget.selectedDate.toString().substring(0, 10)
                    : widget.hint,
                style: widget.selectedDate != null
                    ? inputTextStyle
                    : hintTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              Icons.calendar_month,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
