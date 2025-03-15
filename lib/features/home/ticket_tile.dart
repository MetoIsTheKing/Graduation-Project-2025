import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:timelines_plus/timelines_plus.dart';

class TicketTile extends StatelessWidget {
  const TicketTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context, deviceInfo, constraints) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: deviceInfo.screenHeight * 0.008,
            horizontal: deviceInfo.screenWidth * 0.02,
          ),
          child: ClipPath(
            clipper: TicketClipper(),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: deviceInfo.screenWidth * 0.08,
                vertical: deviceInfo.screenHeight * 0.015,
              ),
              clipBehavior: Clip.antiAlias,
              constraints: BoxConstraints(
                minWidth: deviceInfo.screenWidth * 0.8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(deviceInfo.screenWidth * 0.05),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'LGA',
                          style: TextStyles.medium20(
                              deviceInfo, AppColors.appDarkBlue),
                        ),
                        FixedTimeline(
                          direction: Axis.horizontal,
                          children: [
                            OutlinedDotIndicator(
                              color: AppColors.appYellow,
                              size: deviceInfo.screenWidth * 0.03,
                            ),
                            SizedBox(
                              width: deviceInfo.screenWidth * 0.3,
                              child: DecoratedLineConnector(
                                thickness: 4,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.yellow,
                                      AppColors.appYellow
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            OutlinedDotIndicator(
                              color: AppColors.appYellow,
                              size: deviceInfo.screenWidth * 0.03,
                            ),
                          ],
                        ),
                        Text(
                          'DAD',
                          style: TextStyles.medium20(
                              deviceInfo, AppColors.appDarkBlue),
                        ),
                      ],
                    ),
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'New York',
                          style: TextStyles.medium16(deviceInfo, Colors.grey),
                        ),
                        Text('23:00 hours',
                            style: TextStyles.medium12(
                                deviceInfo, AppColors.appDarkBlue)),
                        Text(
                          'Da Nang',
                          style: TextStyles.medium16(deviceInfo, Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: deviceInfo.screenHeight * 0.025),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('8:00 AM',
                            style: TextStyles.medium20(
                                deviceInfo, AppColors.appDarkBlue)),
                        Text('9:00 AM',
                            style: TextStyles.medium20(
                                deviceInfo, AppColors.appDarkBlue)),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('August 28, 2021',
                          style: TextStyles.regular14(deviceInfo, Colors.grey)),
                      Text('August 28, 2021',
                          style: TextStyles.regular14(deviceInfo, Colors.grey)),
                    ],
                  ),
                  SizedBox(height: deviceInfo.screenHeight * 0.01),
                  Divider(
                    thickness: 2,
                    color: Colors.grey.shade200,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IntrinsicWidth(
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  deviceInfo.screenWidth * 0.05),
                              clipBehavior: Clip.antiAlias,
                              child: Image.asset(
                                'assets/images/airline_logo.png',
                                height: deviceInfo.screenHeight * 0.05,
                              ),
                            ),
                            Text('Qatar Airways',
                                style: TextStyles.regular14(deviceInfo,
                                    const Color.fromARGB(255, 119, 119, 119))),
                          ],
                        ),
                      ),
                      Text('350 \$',
                          style: TextStyles.medium20(
                              deviceInfo, AppColors.appDarkBlue)),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Step 1: Draw the base rectangle (200x200)
    path.moveTo(0, 0); // Start at top-left
    path.lineTo(size.width, 0); // Top-right
    path.lineTo(size.width, size.height); // Bottom-right
    path.lineTo(0, size.height); // Bottom-left
    path.close(); // Back to (0, 0)

    // Step 2: Subtract the left circular cutout
    final Rect leftCircle = Rect.fromCircle(
      center: Offset(0, size.height * 0.7),
      radius: size.width * 0.05,
    );
    path = Path.combine(
      PathOperation.difference,
      path,
      Path()..addOval(leftCircle),
    );

    // Step 3: Subtract the right circular cutout
    final Rect rightCircle = Rect.fromCircle(
      center: Offset(size.width, size.height * 0.7),
      radius: size.width * 0.05,
    );
    path = Path.combine(
      PathOperation.difference,
      path,
      Path()..addOval(rightCircle),
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
