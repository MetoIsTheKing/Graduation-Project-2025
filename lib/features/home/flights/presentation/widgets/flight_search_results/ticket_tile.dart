import 'package:flutter/material.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_functions/mapping_airlines_codes.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/flights/data/models/flight_result_model.dart';
import 'package:timelines_plus/timelines_plus.dart';

class TicketTile extends StatelessWidget {
  final FlightResultModel flight;
  final String arrivalAirportName;
  final String departureAirportName;
  final String baggageAvailability;
  final String tagData;
  final double? scaleFactor;
  final bool? isRecommended;
  final void Function(FlightResultModel flight)? onTap;
  const TicketTile({
    super.key,
    required this.baggageAvailability,
    required this.tagData,
    this.scaleFactor,
    this.isRecommended,
    required this.flight,
    required this.arrivalAirportName,
    required this.departureAirportName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context, deviceInfo, constraints) {
        bool isTablet = false;
        return InkWell(
          onTap: () => onTap!(flight),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: isTablet ? 0 : deviceInfo.screenHeight * 0.01,
              horizontal: deviceInfo.screenWidth * 0.02,
            ),
            child: ClipPath(
              clipper: TicketClipper(),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: deviceInfo.screenWidth * 0.06,
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
                              flight.itineraries[0].segments[0].departure
                                  .iataCode,
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
                                      '${flight.itineraries[0].segments.length - 1} Stops',
                                      style: medium12.copyWith(
                                        color: AppColors.appDarkBlue,
                                      ),
                                    ),
                                  ),
                                  contents: Padding(
                                    padding: EdgeInsets.only(
                                        top: constraints.maxWidth * 0.005),
                                    child: Text(
                                        flight
                                            .itineraries[0].totalFlightDuration
                                            .substring(2)
                                            .replaceAll("H", 'H '),
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
                              flight
                                  .itineraries[0]
                                  .segments[
                                      flight.itineraries[0].segments.length - 1]
                                  .arrival
                                  .iataCode,
                              style: medium20,
                            ),
                          ],
                        ),
                      ),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: constraints.maxWidth * 0.4,
                              child: Text(
                                arrivalAirportName,
                                style: medium10,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: constraints.maxWidth * 0.02,
                            ),
                            SizedBox(
                              width: constraints.maxWidth * 0.4,
                              child: Text(
                                textAlign: TextAlign.end,
                                departureAirportName,
                                style: medium10,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: deviceInfo.screenHeight * 0.008),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                flight.itineraries[0].segments[0].departure
                                    .departureDateTime
                                    .substring(12, 16),
                                style: medium20),
                            Text(
                                flight
                                    .itineraries[0]
                                    .segments[
                                        flight.itineraries[0].segments.length -
                                            1]
                                    .arrival
                                    .arrivalDateTime
                                    .substring(12, 16),
                                style: medium20),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              flight.itineraries[0].segments[0].departure
                                  .departureDateTime
                                  .substring(0, 10),
                              style: medium12),
                          Text(
                              flight
                                  .itineraries[0]
                                  .segments[
                                      flight.itineraries[0].segments.length - 1]
                                  .arrival
                                  .arrivalDateTime
                                  .substring(0, 10),
                              style: medium12),
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
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: deviceInfo.screenWidth * 0.01),
                                  child: Image.asset(
                                    'assets/images/airport_logo_ic.png',
                                    scale: deviceInfo.screenWidth * 0.004,
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.4,
                                  child: Text(
                                    getAirlineName(flight.itineraries[0]
                                            .segments[0].carrierCode)
                                        .toString(),
                                    style: medium12,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IntrinsicHeight(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Starts from', style: medium10),
                                //! text size exception
                                FittedBox(
                                  child: Text('${flight.price.total} \$',
                                      style: medium20),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //? this is the baggage availability tag --------------------
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //       vertical: deviceInfo.screenHeight * 0.008),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       CircleAvatar(
                      //         radius: deviceInfo.screenWidth * 0.01,
                      //         backgroundColor: AppColors.appYellow,
                      //       ),
                      //       Padding(
                      //         padding: EdgeInsets.only(
                      //             left: deviceInfo.screenWidth * 0.012),
                      //         child: Text('See Details', style: medium10),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      //? this is the recommendation tag ----------------------
                      // IntrinsicHeight(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       GestureDetector(
                      //         behavior: HitTestBehavior.opaque,
                      //         onTap: () => onTap!(flight),
                      //         child: RecommendationTag(
                      //             tagColor: AppColors.appGreen,
                      //             deviceInfo: deviceInfo,
                      //             constraints: constrain,
                      //             tagData: 'See Details',
                      //             medium12: medium20.copyWith(
                      //               fontSize: constrain.maxWidth * 0.058,
                      //             )),
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  );
                }),
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
