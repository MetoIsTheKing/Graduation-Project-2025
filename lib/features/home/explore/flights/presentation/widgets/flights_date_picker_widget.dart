import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flights_utils.dart';
import 'package:intl/intl.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';

class FlightsDatePickerWidget extends StatelessWidget {
  final String hint;
  final DateTime? departureDate;
  final DateTime? returnDate;
  final String? prefixIcon;
  final Function(DateTime?) onDateSelected;

  const FlightsDatePickerWidget({
    super.key,
    required this.hint,
    required this.departureDate,
    required this.onDateSelected,
    // Add this line
    this.prefixIcon,
    this.returnDate,
    DateTime? selectedDate,
  });

  void _openDatePicker(BuildContext context) async {
    DateTime? pickedDate;
    final deviceInfo = getIt<DeviceInfo>();
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Theme(
          data: ThemeData.light().copyWith(
              focusColor: Colors.amberAccent, //OK/Cancel button text color
              primaryColor: const Color(0xFF4A5BF6), //Head background
              highlightColor: Colors.cyan //selection color
              ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 96, 88, 88),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: deviceInfo.screenHeight * 0.5,
                  child: CalendarDatePicker(
                    initialDate: departureDate ?? DateTime.now(),
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
                    TextButton(
                      onPressed: () {
                        onDateSelected(null); // Reset date to null
                        Navigator.pop(context);
                      },
                      child: const Text("Reset",
                          style: TextStyle(color: Colors.orange)),
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
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceInfo = getIt<DeviceInfo>();
    return GestureDetector(
      onTap: () => _openDatePicker(context),
      child: Container(
        height: deviceInfo.screenHeight > deviceInfo.screenWidth
            ? deviceInfo.screenHeight * 0.06
            : deviceInfo.screenWidth * 0.079,
        decoration: BoxDecoration(
          color: AppColors.appLighterGrey,
          borderRadius: BorderRadius.circular(
              deviceInfo.screenHeight * 0.02), // Replace this line
        ),
        width: double.infinity,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: deviceInfo.screenWidth * 0.03,
                vertical: deviceInfo.screenHeight * 0.01,
              ), // Adjust padding as needed
              child: prefixIcon != null
                  ? Image.asset(
                      prefixIcon!,
                      width: deviceInfo.screenWidth *
                          0.001, // Adjust size if needed
                      height: deviceInfo.screenHeight * 0.001,
                    )
                  : null,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    departureDate != null
                        ? DateFormat("MMMM d, yyyy").format(departureDate!)
                        : hint,
                    style: departureDate != null
                        ? TextStyles.mediumDark16.copyWith(
                            fontSize: deviceInfo.screenWidth * 0.03,
                            color: Colors.black) // Replace this line
                        : TextStyles.mediumDark16.copyWith(
                            fontSize: deviceInfo.screenWidth * 0.03,
                            color: Colors.grey), // Replace this line
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: deviceInfo.screenWidth * 0.03),
                    child: Text(
                      returnDate != null
                          ? DateFormat("MMMM d, yyyy").format(returnDate!)
                          : '',
                      style: TextStyles.mediumDark16.copyWith(
                          fontSize: deviceInfo.screenWidth * 0.03,
                          color: Colors.black), // Replace this line
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
