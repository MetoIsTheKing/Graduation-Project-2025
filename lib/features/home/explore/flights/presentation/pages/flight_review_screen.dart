import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/helpers/my_logger.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/models/flight_review_data_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/flight_review/flight_review_cubit.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flight_review/baggage_slider.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flight_review/floating_button.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flight_review/trip_header.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flight_review/trip_timeline.dart';

import '../../data/models/flight_result_model.dart';
import '../widgets/flight_review/amenities_container.dart';

class FlightReviewScreen extends StatefulWidget {
  final FlightResultModel flight;
  const FlightReviewScreen({super.key, required this.flight});

  @override
  State<FlightReviewScreen> createState() => _FlightReviewScreenState();
}

class _FlightReviewScreenState extends State<FlightReviewScreen> {
  late FlightReviewDataModel flightModel;

  @override
  void initState() {
    super.initState();
    flightModel = FlightReviewDataModel(flight: widget.flight);
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
            create: (context) => FlightReviewCubit(),
            child: Builder(builder: (context) {
              FlightReviewCubit cubit = FlightReviewCubit.get(context);
              return Scaffold(
                backgroundColor: Colors.transparent,
                floatingActionButton: FloatingButton(
                    Currency: flightModel.totalPrice,
                    onPressed: () {
                      for (var segment in flightModel.segments) {
                        MyLogger.green(
                            'Flight Review Screen Departure: ${segment.departure.iataCode}, Arrival: ${segment.arrival.iataCode}');
                      }
                    }),
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
                            BlocBuilder<FlightReviewCubit, FlightReviewState>(
                              builder: (context, state) {
                                return BaggageSlider(
                                  onTap: cubit.onBaggageSelected,
                                  counter: cubit.selectedBaggage,
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
                                  Text(
                                    'Amenities',
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
                              const AmenitiesContainer(),
                              SizedBox(
                                height: deviceInfo.screenHeight * 0.1,
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
