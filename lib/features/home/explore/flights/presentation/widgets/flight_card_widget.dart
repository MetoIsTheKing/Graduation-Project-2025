import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/flights_data_cubit.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flight_actions_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flight_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flights_form_widget.dart';

class FlightCardWidget extends StatelessWidget {
  const FlightCardWidget({
    super.key,
    required this.index,
    required this.flightModel,
    required this.onDeleteCardPressed,
    required this.flightActionsModel,
    required this.cubit,
  });
  final int index;
  final FlightsDataCubit cubit;
  final FlightModel flightModel;
  final FlightActionsModel flightActionsModel;
  final Function(int index) onDeleteCardPressed;

  @override
  Widget build(BuildContext context) {
    final deviceInfo = getIt<DeviceInfo>();
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              deviceInfo.screenHeight * 0.02, // Replace this line
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
                      deviceInfo.screenHeight * 0.02, // Replace this line
                    ),
                    topRight: Radius.circular(
                      deviceInfo.screenHeight * 0.02, // Replace this line
                    ),
                  ),
                  color: AppColors.appBlue,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: deviceInfo.screenWidth * 0.03,
                  vertical: deviceInfo.screenHeight * 0.01,
                ), // Replace this line
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Flight ${index + 1}',
                      style: TextStyles.regular16(deviceInfo, Colors.white)
                          .copyWith(
                              fontSize: deviceInfo.screenWidth *
                                  0.03), // Replace this line
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          deviceInfo.screenHeight * 0.05, // Replace this line
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
                padding: EdgeInsets.symmetric(
                  horizontal: deviceInfo.screenWidth * 0.03,
                  vertical: deviceInfo.screenHeight * 0.02,
                ), // Replace this line
                child: FlightsFormWidget(
                  dataCubit: cubit,
                  flightModel: flightModel,
                  flightActionsModel: flightActionsModel,
                  isMultiCity: true,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: deviceInfo.screenHeight * 0.02,
        ),
      ],
    );
  }
}
