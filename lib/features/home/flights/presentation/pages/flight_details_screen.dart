import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/booking/data/models/booking_sub_models.dart';
import 'package:graduation_project_2025/features/booking/data/models/one_way_booking_model.dart';
import 'package:graduation_project_2025/features/home/flights/data/models/flight_details_data_model.dart';
import 'package:graduation_project_2025/features/home/flights/presentation/cubits/flight_details/flight_details_cubit.dart';
import 'package:graduation_project_2025/features/home/flights/presentation/widgets/flight_details/baggage_slider.dart';
import 'package:graduation_project_2025/features/home/flights/presentation/widgets/flight_details/floating_button.dart';
import 'package:graduation_project_2025/features/home/flights/presentation/widgets/flight_details/trip_header.dart';
import 'package:graduation_project_2025/features/home/flights/presentation/widgets/flight_details/trip_timeline.dart';

import '../../data/models/flight_result_model.dart';
import '../widgets/flight_details/amenities_container.dart';

class FlightDetailsScreen extends StatefulWidget {
  final FlightResultModel flight;
  final bool isEconomy;
  final void Function(BaggageOptionModel baggageOption, double totalPrice)
      onContinuePressed;
  const FlightDetailsScreen(
      {super.key,
      required this.flight,
      required this.isEconomy,
      required this.onContinuePressed});

  @override
  State<FlightDetailsScreen> createState() => _FlightDetailsScreenState();
}

class _FlightDetailsScreenState extends State<FlightDetailsScreen> {
  late FlightDetailsDataModel flightModel;

  @override
  void initState() {
    super.initState();
    flightModel = FlightDetailsDataModel(
        flight: widget.flight, isEconomy: widget.isEconomy);
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo, constrains) {
      return Stack(
        children: [
          Center(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.appBlue,
                image: DecorationImage(
                  image: AssetImage('assets/images/global_map.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => FlightDetailsCubit(),
            child: Builder(builder: (context) {
              FlightDetailsCubit cubit = FlightDetailsCubit.get(context);
              return Scaffold(
                backgroundColor: Colors.transparent,
                floatingActionButton:
                    BlocBuilder<FlightDetailsCubit, FlightDetailsState>(
                  builder: (context, state) {
                    return FloatingButton(
                        currency:
                            "${((double.tryParse(flightModel.basicPrice)! + cubit.extraPrice) * 100).round() / 100}",
                        onPressed: () {
                          getIt<OneWayBookingModel>().travellersInfo = [];
                          widget.onContinuePressed(
                            BaggageOptionModel(
                              type: baggageDetails[widget.isEconomy ? 0 : 1]
                                  [cubit.selectedBaggage - 1]['title'],
                              price: baggageDetails[widget.isEconomy ? 0 : 1]
                                  [cubit.selectedBaggage - 1]['extraAmount'],
                              weight: baggageDetails[widget.isEconomy ? 0 : 1]
                                  [cubit.selectedBaggage - 1]['weight'],
                            ),
                            (double.tryParse(flightModel.basicPrice)! +
                                cubit.extraPrice),
                          );
                        });
                  },
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                body: SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceInfo.screenWidth * 0.05,
                              vertical: deviceInfo.screenHeight * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TripHeader(
                                flight: flightModel,
                              ),
                              SizedBox(
                                height: deviceInfo.screenHeight * 0.02,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Trip Timeline',
                                    style: TextStyles.bold20(
                                            deviceInfo, Colors.white)
                                        .copyWith(
                                            fontSize:
                                                deviceInfo.screenWidth * 0.055),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: deviceInfo.screenHeight * 0.01,
                              ),
                              TripTimeline(
                                flight: flightModel,
                              ),
                              SizedBox(
                                height: deviceInfo.screenHeight * 0.03,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Baggage Allowance',
                                    style: TextStyles.bold20(
                                            deviceInfo, Colors.white)
                                        .copyWith(
                                            fontSize:
                                                deviceInfo.screenWidth * 0.055),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(height: deviceInfo.screenHeight * 0.01),
                            BlocBuilder<FlightDetailsCubit, FlightDetailsState>(
                              builder: (context, state) {
                                return BaggageSlider(
                                  onTap: cubit.onBaggageSelected,
                                  counter: cubit.selectedBaggage,
                                  isEconomy: flightModel.isEconomy,
                                );
                              },
                            ),
                            SizedBox(
                              height: deviceInfo.screenHeight * 0.02,
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: deviceInfo.screenWidth * 0.05,
                            vertical: deviceInfo.screenHeight * 0.02,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  flightModel.amenities.isEmpty
                                      ? SizedBox()
                                      : Text(
                                          'Amenities',
                                          style: TextStyles.bold20(
                                                  deviceInfo, Colors.white)
                                              .copyWith(
                                                  fontSize:
                                                      deviceInfo.screenWidth *
                                                          0.055),
                                        ),
                                ],
                              ),
                              SizedBox(
                                height: deviceInfo.screenHeight * 0.01,
                              ),
                              AmenitiesContainer(
                                flight: flightModel,
                              ),
                              SizedBox(
                                height: deviceInfo.screenHeight * 0.15,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      );
    });
  }
}
