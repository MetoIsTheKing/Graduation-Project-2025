import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/features/home/airport_text_input.dart';
import 'package:graduation_project_2025/features/home/current_location_tile.dart';
import 'package:graduation_project_2025/features/home/curved_appbar.dart';

final deviceInfo = getIt<DeviceInfo>();

class SearchAirport extends StatelessWidget {
  final bool isOrigin;
  const SearchAirport({super.key, required this.isOrigin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CurvedAppbar(
        title: "Search Origin",
        onBack: () => context.pop(),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: deviceInfo.screenWidth * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AirportTextInput(
              iconPath: isOrigin
                  ? 'assets/images/plane_up.svg'
                  : 'assets/images/plane_down.svg',
            ),
            CurrentLocationTile(
              onTap: () {
                print('clicked');
              },
            ),
          ],
        ),
      ))),
    );
  }
}
