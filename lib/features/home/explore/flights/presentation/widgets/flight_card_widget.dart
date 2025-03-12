import 'package:flutter/material.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flight_actions_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flight_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flights_utils.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flights_form_widget.dart';

class FlightCardWidget extends StatelessWidget {
  const FlightCardWidget({
    super.key,
    required this.index,
    required this.flightModel,
    required this.onDeleteCardPressed,
    required this.flightActionsModel,
  });
  final int index;
  final FlightModel flightModel;
  final FlightActionsModel flightActionsModel;
  final Function(int index) onDeleteCardPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          FlightsUtils.cardBorderRadius,
        ),
      ),
      color: Colors.white,
      elevation: 5,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  FlightsUtils.cardBorderRadius,
                ),
                topRight: Radius.circular(
                  FlightsUtils.cardBorderRadius,
                ),
              ),
              color: AppColors.appBlue,
            ),
            padding: FlightsUtils.cardHeaderPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Flight ${index + 1}',
                  style: FlightsUtils.cardLabelStyle,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      FlightsUtils.deleteButtonBorderRadius,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () => onDeleteCardPressed(
                      index,
                    ),
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: FlightsUtils.cardContentPadding,
            child: FlightsFormWidget(
              flightModel: flightModel,
              flightActionsModel: flightActionsModel,
            ),
          ),
        ],
      ),
    );
  }
}
