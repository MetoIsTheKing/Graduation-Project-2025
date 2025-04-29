import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_app_bar.dart';
import 'package:timelines_plus/timelines_plus.dart';

class TripTimeline extends StatelessWidget {
  const TripTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    int itemCount = 2;
    return Container(
      height: itemCount * deviceInfo.screenHeight * 0.17,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          vertical: deviceInfo.screenHeight * 0.02,
          horizontal: deviceInfo.screenWidth * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(deviceInfo.screenWidth * 0.05),
      ),
      child: FixedTimeline.tileBuilder(
        builder: TimelineTileBuilder.connectedFromStyle(
          contentsAlign: ContentsAlign.reverse,
          firstConnectorStyle: ConnectorStyle.dashedLine,
          lastConnectorStyle: ConnectorStyle.dashedLine,

          // determines where the timeline stands horizontally
          nodePositionBuilder: (context, index) =>
              deviceInfo.screenWidth * 0.0008,

          // determines the position of the node
          indicatorPositionBuilder: (context, index) {
            if (index == 0) {
              return deviceInfo.screenWidth * 0.00001;
            }
            if (index == itemCount - 1) {
              return deviceInfo.screenWidth * 0.0025;
            }
            return deviceInfo.screenHeight * 0.0005;
          },

          // determines the vertica space for each content
          itemExtentBuilder: (context, index) => deviceInfo.screenHeight * 0.15,
          oppositeContentsBuilder: (context, index) =>
              _dateColumn(itemCount, index),
          contentsBuilder: (context, index) => _airportColumn(itemCount, index),
          connectorStyleBuilder: (context, index) => ConnectorStyle.dashedLine,
          indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
          itemCount: itemCount,
        ),
      ),
    );
  }

  Widget _airportColumn(itemCount, index) {
    return SizedBox(
      height: deviceInfo.screenHeight * 0.2,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: _mainAxisAlignment(itemCount, index),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '02:30 Am',
            style: TextStyles.semiBold12(deviceInfo, AppColors.appDarkBlack),
          ),
          Text('20 feb',
              style: TextStyles.medium12(
                deviceInfo,
                AppColors.appDarkGrey,
              )),
        ],
      ),
    );
  }

  Widget _dateColumn(itemCount, index) {
    return Container(
      height: deviceInfo.screenHeight * 0.2,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: deviceInfo.screenWidth * 0.02,
      ),
      child: Column(
        mainAxisAlignment: _mainAxisAlignment(itemCount, index),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'King Khaled International Airport (RUH)',
            style: TextStyles.medium12(deviceInfo, AppColors.appDarkBlack),
            textAlign: TextAlign.center,
            maxLines: 2,
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
                  'Terminal 1',
                  style:
                      TextStyles.medium12(deviceInfo, AppColors.appDarkBlack),
                ),
              ),
              SizedBox(
                width: deviceInfo.screenWidth * 0.02,
              ),
              Expanded(
                child: Text(
                  'Riyadh , Saudi Arabia',
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
      return MainAxisAlignment.start;
    } else if (index == itemCount - 1) {
      return MainAxisAlignment.end;
    } else {
      return MainAxisAlignment.center;
    }
  }
}
