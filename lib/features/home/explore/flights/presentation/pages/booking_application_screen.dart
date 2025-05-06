import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/traveler_info_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/curved_appbar.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/total_price_tag.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/traveler_info_tile.dart';

class BookingApplicationScreen extends StatefulWidget {
  final Map<String, int> travelers;
  const BookingApplicationScreen({super.key, required this.travelers});

  @override
  State<BookingApplicationScreen> createState() =>
      _BookingApplicationScreenState();
}

class _BookingApplicationScreenState extends State<BookingApplicationScreen> {
  late List<TravelerInfoModel> travelersInfoList = [];
  late int travelersCount;

  @override
  void initState() {
    // Calculate total travelers count
    travelersCount = widget.travelers['adults'] ?? 0;

    // Add children count if available
    if (widget.travelers.containsKey('children')) {
      travelersCount += widget.travelers['children'] ?? 0;
    }

    // Add infants count if available
    if (widget.travelers.containsKey('infants')) {
      travelersCount += widget.travelers['infants'] ?? 0;
    }
    travelersInfoList = List.generate(
        travelersCount,
        (index) => TravelerInfoModel(
              travelerType: _getTravelerType(index),
              fullName: '',
              birthDate: '',
              nationality: '',
              passportNumber: '',
              passportExpiryDate: '',
              issuingCountry: '',
            ));
    super.initState();
  }

  String _getTravelerType(int index) {
    int adultsCount = widget.travelers['adults'] ?? 0;
    int childrenCount = widget.travelers['children'] ?? 0;

    if (index < adultsCount) {
      // For adults: "Adult 1", "Adult 2", etc.
      return 'Adult ${index + 1}';
    } else if (index < adultsCount + childrenCount) {
      // For children: "Child 1", "Child 2", etc.
      // Calculate the child number by subtracting the adult count
      int childNumber = (index - adultsCount) + 1;
      return 'Child $childNumber';
    } else {
      // For infants: "Infant 1", "Infant 2", etc.
      // Calculate the infant number by subtracting both adult and child counts
      int infantNumber = (index - adultsCount - childrenCount) + 1;
      return 'Infant $infantNumber';
    }
  }

  void submitForm() {
    final jsonList = travelersInfoList.map((t) => t.toJson()).toList();
    print(jsonEncode(jsonList)); // Log all travelers
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo, constraints) {
      return Scaffold(
        appBar: CurvedAppbar(
            onBack: () => context.pop(),
            backgroundColor: AppColors.appBlue,
            titleWidget: Text(
              'Enter travelers details',
              style: TextStyles.medium20(deviceInfo, Colors.white),
            ),
            backButtonColor: Colors.white),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: deviceInfo.screenWidth * 0.05,
              vertical: deviceInfo.screenHeight * 0.03),
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TotalPriceTag(
                  deviceInfo: deviceInfo,
                  totalPrice: '1000',
                  onTapSummary: () {
                    print('view summary');
                  },
                ),
                ListView.builder(
                  itemCount: travelersInfoList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return TravelerInfoTile(
                      travelerInfoModel: travelersInfoList[index],
                      onDataChanged: (updatedTraveler) {
                        travelersInfoList[index] =
                            updatedTraveler; // Update the list
                      },
                    );
                  },
                ),
                //? Contact Info 
                CustomRoundedButton(
                    deviceInfo: deviceInfo,
                    label: 'log',
                    backgroundColor: AppColors.appYellow,
                    onPressed: submitForm,
                    textColor: AppColors.appDarkBlue)
              ],
            ),
          ),
        ),
      );
    });
  }
}
