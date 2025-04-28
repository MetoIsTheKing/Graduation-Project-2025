import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/flights_data_cubit.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/search_flights/search_flights_cubit.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flight_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/airport_text_input.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/pages/flight_search_results_screen.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/search_custom_tile.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/curved_appbar.dart';

class SearchAirport extends StatelessWidget {
  final FlightsDataCubit cubit;
  final String appBarTitle;
  final bool isOrigin;
  final FlightModel flightModel;
  final void Function() onBack;
  const SearchAirport({
    super.key,
    required this.isOrigin,
    required this.appBarTitle,
    required this.onBack,
    required this.flightModel,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final searchFlightsCubit = BlocProvider.of<SearchFlightsCubit>(context);
    return InfoWidget(
      builder: (context, deviceinfo, constrains) {
        print('width inside the info widget : ${deviceinfo.screenWidth}');
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CurvedAppbar(
            backgroundColor: AppColors.appBlue,
            backButtonColor: Colors.white,
            titleWidget: Text(
              appBarTitle,
              style: TextStyles.medium20(deviceinfo, Colors.white),
            ),
            onBack: onBack,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: deviceinfo.screenWidth * 0.08),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AirportTextInput(
                      iconPath: isOrigin
                          ? 'assets/images/plane_up.svg'
                          : 'assets/images/plane_down.svg',
                      airportConteroller: isOrigin
                          ? flightModel.fromController
                          : flightModel.toController,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          return;
                        } else {
                          // Cancel previous searches and wait for 500ms before executing the search
                          // This prevents API calls for every character typed
                          Future.delayed(
                            const Duration(milliseconds: 500),
                          ).then((_) {
                            // Only search if the text hasn't changed during the delay
                            if ((isOrigin
                                        ? flightModel.fromController
                                        : flightModel.toController)
                                    .text ==
                                value) {
                              searchFlightsCubit.searchAirports(value);
                            }
                          });
                        }
                      },
                    ),
                    SearchCustomTile(
                      title: "use current location",
                      tileIconPath: 'assets/images/location_pin.svg',
                      tileBorderColor: Colors.grey,
                      tileFillColor: Colors.white,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const FlightSearchResultsScreen()));
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: deviceinfo.screenHeight * 0.02),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    BlocBuilder<SearchFlightsCubit, SearchFlightsState>(
                      builder: (context, state) {
                        if (state is AirportsIsLoading) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: AppColors.appBlue,
                          ));
                        } else if (state is AirportsOnError) {
                          return Center(child: Text(state.errorMessage));
                        } else if (state is AirportsLoaded) {
                          final airports = state.airports;
                          if (airports.isEmpty) {
                            return Center(
                              child: Text(
                                'No airports found',
                                style: TextStyles.medium16(
                                        deviceinfo, AppColors.appDarkBlue)
                                    .copyWith(
                                        fontSize:
                                            deviceinfo.screenHeight * 0.01),
                              ),
                            );
                          } else {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: airports.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: deviceinfo.screenHeight * 0.015),
                                  child: SearchCustomTile(
                                    onTap: () {
                                      if (isOrigin == true) {
                                        cubit.updateFrom(
                                            airports[index].iataCode);
                                        log('origin airport is : ${flightModel.fromController.text}');
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BlocProvider.value(
                                              value: searchFlightsCubit,
                                              child: SearchAirport(
                                                cubit: cubit,
                                                flightModel: flightModel,
                                                isOrigin: false,
                                                appBarTitle:
                                                    'Search Destination',
                                                onBack: context.pop,
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        cubit
                                            .updateTo(airports[index].iataCode);
                                        log('destination airport is : ${flightModel.toController.text}');

                                        context.pushReplacementNamed(
                                            Routes.flights);
                                      }
                                    },
                                    title: airports[index].name,
                                    tileIconPath:
                                        'assets/images/airport_icon.svg',
                                    tileFillColor: Colors.white,
                                    tileBorderColor: AppColors.appBlue,
                                    subtitle: Text(
                                      '${airports[index].countryName} , ${airports[index].cityName}',
                                      style: TextStyles.medium16(
                                              deviceinfo, Colors.grey)
                                          .copyWith(
                                              fontSize:
                                                  deviceinfo.screenHeight *
                                                      0.01),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        } else {
                          return Center(
                            child: Text(
                              'Unexpected error occurred',
                              style: TextStyles.medium16(
                                      deviceinfo, Colors.grey)
                                  .copyWith(
                                      fontSize: deviceinfo.screenHeight * 0.01),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
