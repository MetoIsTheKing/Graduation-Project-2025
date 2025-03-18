import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/recommendation_tag.dart';
import 'package:timelines_plus/timelines_plus.dart';

class TicketTile extends StatelessWidget {
  final String originAirport;
  final String destinationAirport;
  final String originCity;
  final String destinationCity;
  final String departureTime;
  final String arrivalTime;
  final String departureDate;
  final String arrivalDate;
  final String airlineName;
  final String airlineLogo;
  final String flightDuration;
  final int stopsNumber;
  final String price;
  final String baggageAvailability;
  final String tagData;
  final double? scaleFactor;
  final bool isRecommended;
  const TicketTile({
    super.key,
    required this.originAirport,
    required this.destinationAirport,
    required this.originCity,
    required this.destinationCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.departureDate,
    required this.arrivalDate,
    required this.airlineName,
    required this.airlineLogo,
    required this.price,
    required this.stopsNumber,
    required this.flightDuration,
    required this.baggageAvailability,
    required this.tagData,
    this.scaleFactor,
    required this.isRecommended,
  });

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context, deviceInfo, constraints) {
        bool isTablet = deviceInfo.deviceType == DeviceType.tablet;
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: isTablet ? 0 : deviceInfo.screenHeight * 0.01,
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
                maxWidth: isTablet
                    ? deviceInfo.screenWidth * 0.75 * scaleFactor!
                    : deviceInfo.screenWidth * 0.9,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(deviceInfo.screenWidth * 0.05),
              ),
              child: LayoutBuilder(builder: (context, constrain) {
                final TextStyle medium20 = TextStyle(
                  fontSize: constrain.maxWidth * 0.068,
                  color: AppColors.appDarkBlue,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                );
                final TextStyle medium12 = TextStyle(
                  fontSize: constrain.maxWidth * 0.05,
                  color: AppColors.appDarkGrey,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                );
                final TextStyle medium10 = TextStyle(
                  fontSize: constrain.maxWidth * 0.042,
                  color: AppColors.appDarkBlue,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                );

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            originAirport,
                            style: medium20,
                          ),
                          FixedTimeline(
                            direction: Axis.horizontal,
                            children: [
                              OutlinedDotIndicator(
                                color: AppColors.appYellow,
                                size: deviceInfo.screenWidth * 0.03,
                              ),
                              TimelineTile(
                                oppositeContents: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: constraints.maxWidth * 0.005),
                                  child: Text(
                                    '$stopsNumber Stops',
                                    style: medium12.copyWith(
                                      color: AppColors.appDarkBlue,
                                    ),
                                  ),
                                ),
                                contents: Padding(
                                  padding: EdgeInsets.only(
                                      top: constraints.maxWidth * 0.005),
                                  child: Text(flightDuration,
                                      style: medium12.copyWith(
                                          color: AppColors.appDarkBlue)),
                                ),
                                node: SizedBox(
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
                              ),
                              OutlinedDotIndicator(
                                color: AppColors.appYellow,
                                size: deviceInfo.screenWidth * 0.03,
                              ),
                            ],
                          ),
                          Text(
                            destinationAirport,
                            style: medium20,
                          ),
                        ],
                      ),
                    ),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            originCity,
                            style: medium12,
                          ),
                          Text(
                            destinationCity,
                            style: medium12,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: deviceInfo.screenHeight * 0.008),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(departureTime, style: medium20),
                          Text(arrivalTime, style: medium20),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(departureDate, style: medium12),
                        Text(arrivalDate, style: medium12),
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
                                  airlineLogo,
                                  height: deviceInfo.screenHeight * 0.04,
                                ),
                              ),
                              Text(airlineName, style: medium12),
                            ],
                          ),
                        ),
                        IntrinsicHeight(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Starts from', style: medium10),
                              Text('$price \$', style: medium20),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: deviceInfo.screenHeight * 0.008),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: deviceInfo.screenWidth * 0.01,
                            backgroundColor: AppColors.appYellow,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: deviceInfo.screenWidth * 0.012),
                            child: Text(baggageAvailability, style: medium10),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isRecommended,
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RecommendationTag(
                                tagColor: AppColors.appBlue,
                                deviceInfo: deviceInfo,
                                constraints: constrain,
                                tagData: tagData,
                                medium12: medium12),
                            RecommendationTag(
                                tagColor: Colors.green,
                                deviceInfo: deviceInfo,
                                constraints: constrain,
                                tagData: tagData,
                                medium12: medium12),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }),
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
      radius: size.width * 0.04,
    );
    path = Path.combine(
      PathOperation.difference,
      path,
      Path()..addOval(leftCircle),
    );

    // Step 3: Subtract the right circular cutout
    final Rect rightCircle = Rect.fromCircle(
      center: Offset(size.width, size.height * 0.7),
      radius: size.width * 0.04,
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
