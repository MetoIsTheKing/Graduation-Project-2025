import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/helpers/my_logger.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/shared_functions/mapping_airports_codes.dart';
import 'package:graduation_project_2025/features/home/my_bookings/data/models/my_booking_model.dart';
import 'package:timelines_plus/timelines_plus.dart';

import '../../../../../core/responsive/Models/device_info.dart';
import '../../../../../core/responsive/ui_component/info_widget.dart';
import '../../../../../core/utils/app_colors.dart';

class MyBookingContainer extends StatelessWidget {
  const MyBookingContainer(
      {super.key, required this.booking, required this.cancelBooking});
  final MyBookingsModel booking;
  final void Function() cancelBooking;

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo, constraints) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: AppColors.appGrey,
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header Section ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Booking Ref.',
                  style:
                      TextStyles.regular12(deviceInfo, AppColors.appDarkGrey),
                ),
                Expanded(
                  child: Text(
                    booking.bookingRef,
                    textAlign: TextAlign.center,
                    style:
                        TextStyles.semiBold18(deviceInfo, AppColors.appYellow),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.appBlue.withAlpha(25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    booking.bookingType == 'ONE_WAY' ? 'One Way' : 'Round Trip',
                    style: TextStyles.regular12(deviceInfo, AppColors.appBlue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // --- Price Section ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Price:',
                  style:
                      TextStyles.regular14(deviceInfo, AppColors.appDarkGrey),
                ),
                Text(
                  '${booking.currency} ${booking.totalPrice.toStringAsFixed(2)}',
                  style:
                      TextStyles.semiBold18(deviceInfo, AppColors.appDarkBlue),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(color: AppColors.appGrey, thickness: 1.0),
            ),

            // --- Flight Details Section ---
            booking.bookingType == 'ONE_WAY'
                ? _myBookinggTicket(
                    deviceInfo: deviceInfo,
                    originCode: booking.originAirportCode!,
                    destinationCode: booking.destinationAirportCode!,
                    departureDate: booking.departureDate!,
                    arrivalDate: booking.arrivalDate!,
                    stops: booking.numberOfStops!,
                  )
                : Column(
                    children: [
                      _myBookinggTicket(
                        deviceInfo: deviceInfo,
                        originCode: booking.flightData[0].originAirportCode,
                        destinationCode:
                            booking.flightData[0].destinationAirportCode,
                        departureDate: booking.flightData[0].departureDate,
                        arrivalDate: booking.flightData[0].arrivalDate,
                        stops: booking.flightData[0].numberOfStops,
                      ),
                      const SizedBox(height: 16.0),
                      _myBookinggTicket(
                        deviceInfo: deviceInfo,
                        originCode: booking.flightData[1].originAirportCode,
                        destinationCode:
                            booking.flightData[1].destinationAirportCode,
                        departureDate: booking.flightData[1].departureDate,
                        arrivalDate: booking.flightData[1].arrivalDate,
                        stops: booking.flightData[1].numberOfStops,
                      )
                    ],
                  ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(color: AppColors.appGrey, thickness: 1.0),
            ),

            // --- Passenger Section ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Passenger',
                  style:
                      TextStyles.regular12(deviceInfo, AppColors.appDarkGrey),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Seat No.',
                  style:
                      TextStyles.regular12(deviceInfo, AppColors.appDarkGrey),
                )
              ],
            ),
            const SizedBox(height: 8),
            ...booking.travellersInfo.map((traveler) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${traveler.firstName} ${traveler.lastName}',
                        style: TextStyles.medium16(
                            deviceInfo, AppColors.appDarkBlue),
                      ),
                      Text(
                        traveler.seatNumber,
                        style: TextStyles.medium16(
                            deviceInfo, AppColors.appDarkBlue),
                      ),
                    ],
                  ),
                )),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(color: AppColors.appGrey, thickness: 1.0),
            ),

            // --- Action Button ---
            CustomRoundedButton(
              deviceInfo: deviceInfo,
              label: 'Cancel Flight',
              backgroundColor: AppColors.appRed,
              onPressed: () {
                cancelBooking();
              },
              textColor: Colors.white,
            )
          ],
        ),
      );
    });
  }

  Widget _myBookinggTicket({
    required DeviceInfo deviceInfo,
    required String originCode,
    required String destinationCode,
    required DateTime departureDate,
    required DateTime arrivalDate,
    required int stops,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.appLighterGrey,
        border: Border.all(
          color: AppColors.appGrey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                originCode,
                style: TextStyles.semiBold18(deviceInfo, AppColors.appDarkBlue),
              ),
              Expanded(
                child: Column(
                  children: [
                    FixedTimeline(
                      direction: Axis.horizontal,
                      children: [
                        const Spacer(),
                        const OutlinedDotIndicator(
                          color: AppColors.appDarkGrey,
                          size: 8,
                        ),
                        SizedBox(
                          width: deviceInfo.screenWidth * 0.25,
                          child: const DecoratedLineConnector(
                            thickness: 1.5,
                            decoration: BoxDecoration(
                              color: AppColors.appDarkGrey,
                            ),
                          ),
                        ),
                        const OutlinedDotIndicator(
                          color: AppColors.appDarkGrey,
                          size: 8,
                        ),
                        const Spacer(),
                      ],
                    ),
                    Text(
                      '$stops Stop${stops == 1 ? '' : 's'}',
                      style: TextStyles.regular12(
                          deviceInfo, AppColors.appDarkGrey),
                    ),
                  ],
                ),
              ),
              Text(
                destinationCode,
                style: TextStyles.semiBold18(deviceInfo, AppColors.appDarkBlue),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  getAirportDetails(originCode)['name']!,
                  style:
                      TextStyles.regular12(deviceInfo, AppColors.appDarkGrey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: Text(
                  getAirportDetails(destinationCode)['name']!,
                  textAlign: TextAlign.end,
                  style:
                      TextStyles.regular12(deviceInfo, AppColors.appDarkGrey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(departureDate.toString().substring(0, 10),
                  style:
                      TextStyles.regular14(deviceInfo, AppColors.appDarkBlue)),
              Text(arrivalDate.toString().substring(0, 10),
                  style:
                      TextStyles.regular14(deviceInfo, AppColors.appDarkBlue)),
            ],
          ),
        ],
      ),
    );
  }
}
