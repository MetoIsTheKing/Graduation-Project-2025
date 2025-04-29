import 'package:flutter/material.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_app_bar.dart';
import 'package:timelines_plus/timelines_plus.dart';

class TripTimeline extends StatelessWidget {
  const TripTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    int itemCount = 3;
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
          // itemExtent: 100,
          firstConnectorStyle: ConnectorStyle.dashedLine,
          lastConnectorStyle: ConnectorStyle.dashedLine,
          nodePositionBuilder: (context, index) =>
              deviceInfo.screenWidth * 0.0008,
          indicatorPositionBuilder: (context, index) {
            if (index == 0) {
              return deviceInfo.screenWidth * 0.00001;
            }
            if (index == itemCount - 1) {
              return deviceInfo.screenWidth * 0.0025;
            }
            return deviceInfo.screenHeight * 0.0005;
          },
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
          Text('dataaa'),
          Text('data'),
        ],
      ),
    );
  }

  Widget _dateColumn(itemCount, index) {
    return SizedBox(
      height: deviceInfo.screenHeight * 0.2,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: _mainAxisAlignment(itemCount, index),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('data'),
          Text('data'),
        ],
      ),
    );
  }

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
