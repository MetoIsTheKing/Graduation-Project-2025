import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/shared_functions/mapping_airports_codes.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_app_bar.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/models/flight_details_data_model.dart';
import 'package:timelines_plus/timelines_plus.dart';

class TripTimeline extends StatelessWidget {
  const TripTimeline({super.key, required this.flight});
  final FlightDetailsDataModel flight;

  @override
  Widget build(BuildContext context) {
    int itemCount = flight.segments.length + 1;
    return Container(
      //   height: itemCount * deviceInfo.screenHeight * 0.18,
      clipBehavior: Clip.antiAlias,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: deviceInfo.screenWidth * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(deviceInfo.screenWidth * 0.05),
      ),
      child: Timeline.tileBuilder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        builder: TimelineTileBuilder.connected(
          contentsAlign: ContentsAlign.reverse,
          // firstConnectorStyle: ConnectorStyle.dashedLine,
          // lastConnectorStyle: ConnectorStyle.dashedLine,
          // determines where the timeline stands horizontally
          nodePositionBuilder: (context, index) =>
              deviceInfo.screenHeight * 0.00035,

          //  determines the position of the node
          // indicatorPositionBuilder: (context, index) {
          //   if (index == 0) {
          //     return deviceInfo.screenHeight * 0.00000;
          //   }
          //   // this may cause some isuues in different models 🤷‍♂️
          //   if (index == itemCount - 1) {
          //     return deviceInfo.screenHeight * 0.000;
          //   }
          //   return deviceInfo.screenHeight * 0.0007;
          // },

          // determines the vertical space for each content
          itemExtentBuilder: (context, index) => deviceInfo.screenHeight * 0.15,
          oppositeContentsBuilder: (context, index) =>
              _airportColumn(itemCount, index),
          contentsBuilder: (context, index) => _dateColumn(itemCount, index),
          // connectorStyleBuilder: (context, index) => ConnectorStyle.dashedLine,
          // indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
          indicatorBuilder: (context, index) {
            if (index == 0) {
              return DotIndicator(
                color: AppColors.appBlue,
                size: deviceInfo.screenHeight * 0.02,
              );
            } else if (index == itemCount - 1) {
              return DotIndicator(
                color: AppColors.appBlue,
                size: deviceInfo.screenHeight * 0.02,
              );
            } else {
              return OutlinedDotIndicator(
                color: AppColors.appBlue,
                borderWidth: deviceInfo.screenHeight * 0.002,
                size: deviceInfo.screenHeight * 0.02,
              );
            }
          },
          connectorBuilder: (context, index, type) => DashedLineConnector(
            color: AppColors.appBlue,
            thickness: deviceInfo.screenHeight * 0.002,
          ),
          itemCount: itemCount,
        ),
      ),
    );
  }

  Widget _dateColumn(itemCount, index) {
    late String date;
    late String time;
    if (index == 0) {
      date = flight.departureDate;
      time = flight.departureDateTime;
    } else if (index == itemCount - 1) {
      date = flight.arrivalDate;
      time = flight.arrivalDateTime;
    } else {
      date =
          flight.segments[index - 1].arrival.arrivalDateTime.substring(0, 10);
      time =
          flight.segments[index - 1].arrival.arrivalDateTime.substring(11, 16);
    }
    return SizedBox(
      //  height: deviceInfo.screenHeight * 0.2,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: _mainAxisAlignment(itemCount, index),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            time,
            style: TextStyles.semiBold12(deviceInfo, AppColors.appDarkBlack),
          ),
          Text(date,
              style: TextStyles.medium12(
                deviceInfo,
                AppColors.appDarkGrey,
              )),
        ],
      ),
    );
  }

  Widget _airportColumn(itemCount, index) {
    late String airport;
    late String terminal;
    late String city;
    if (index == 0) {
      airport = flight.departureAirport;
      terminal = flight.arrivalTerminal;
      city =
          '${getAirportDetails(flight.departureCode)['city']!}, ${getAirportDetails(flight.departureCode)['country']!}';
    } else if (index == itemCount - 1) {
      airport = flight.arrivalAirport;
      terminal = flight.departureTerminal;
      city =
          '${getAirportDetails(flight.arrivalCode)['city']!}, ${getAirportDetails(flight.arrivalCode)['country']!}';
    } else {
      airport =
          getAirportDetails(flight.segments[index].departure.iataCode)['name']!;

      terminal = flight.segments[index].departure.departureTerminal ?? 'N/A';
      city =
          "${getAirportDetails(flight.segments[index].departure.iataCode)['city']!}, ${getAirportDetails(flight.segments[index].departure.iataCode)['country']!}";
    }
    return Container(
      //height: deviceInfo.screenHeight * 0.2,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: deviceInfo.screenWidth * 0.02,
      ),
      child: Column(
        mainAxisAlignment: _mainAxisAlignment(itemCount, index),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            airport,
            style: TextStyles.medium12(deviceInfo, AppColors.appDarkBlack),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: deviceInfo.screenHeight * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: deviceInfo.screenWidth * 0.02,
                  vertical: deviceInfo.screenHeight * 0.002,
                ),
                decoration: BoxDecoration(
                  color: AppColors.appYellow,
                  borderRadius:
                      BorderRadius.circular(deviceInfo.screenWidth * 0.05),
                ),
                child: Text(
                  'Terminal $terminal',
                  style:
                      TextStyles.regular10(deviceInfo, AppColors.appDarkBlack),
                ),
              ),
              SizedBox(
                width: deviceInfo.screenWidth * 0.02,
              ),
              Expanded(
                child: Text(
                  city,
                  style: TextStyles.medium12(
                    deviceInfo,
                    AppColors.appDarkGrey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // allocate the alignment depending on the position of the node
  MainAxisAlignment _mainAxisAlignment(itemCount, index) {
    if (index == 0) {
      return MainAxisAlignment.center;
    } else if (index == itemCount - 1) {
      return MainAxisAlignment.center;
    } else {
      return MainAxisAlignment.center;
    }
  }
}
