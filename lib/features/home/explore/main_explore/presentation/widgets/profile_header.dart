import 'package:flutter/material.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';

import '../../../../../../config/theming/text_styles.dart';

// user id is passed from the explore screen inside onTap
class ProfileHeader extends StatelessWidget {
  final String userFirstName;
  final String profileImage;
  final void Function()? onTap;
  const ProfileHeader(
      {super.key,
      required this.userFirstName,
      required this.profileImage,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo, constrains) {
      print(constrains.maxWidth);
      print(constrains.maxHeight);
      print('this is hashcod inside profile header: ${deviceInfo.hashCode}');
      return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: deviceInfo.screenWidth * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Hello, $userFirstName',
                      style: TextStyles.semiBold24(deviceInfo, Colors.white),
                    ),
                  ],
                ),
                Text(
                  'Sky is the limit. Explore the world with us.',
                  style: TextStyles.regular14(deviceInfo, Colors.white),
                ),
              ],
            ),
            SizedBox(width: deviceInfo.screenWidth * 0.022),
            InkWell(
              onTap: onTap,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(deviceInfo.screenWidth * 0.12),
                child: Image.asset(
                  profileImage,
                  width: deviceInfo.screenWidth * 0.11,
                  height: deviceInfo.screenWidth * 0.11,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
