import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_2025/config/routing/routes.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/flight_review/flight_review_cubit.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flight_review/baggage_slider.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flight_review/floating_button.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flight_review/trip_header.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/widgets/flight_review/trip_timeline.dart';

class FlightReviewScreen extends StatefulWidget {
  const FlightReviewScreen({super.key});

  @override
  State<FlightReviewScreen> createState() => _FlightReviewScreenState();
}

class _FlightReviewScreenState extends State<FlightReviewScreen> {
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
                appBar: AppBar(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  leading: Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: deviceInfo.screenWidth * 0.05),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: deviceInfo.screenWidth * 0.06,
                      ),
                      onPressed: () {
                        context.pushReplacementNamed(Routes.mainHome);
                      },
                    ),
                  ),
                  title: Text(
                    'Review your trip',
                    style: TextStyles.semiBold18(deviceInfo, Colors.white),
                  ),
                  actionsPadding: EdgeInsetsDirectional.only(
                    end: deviceInfo.screenWidth * 0.05,
                  ),
                  actions: [
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/currency.svg',
                        width: deviceInfo.screenWidth * 0.06,
                      ),
                      onPressed: () {
                        showCurrencyPicker(
                          context: context,
                          showFlag: true,
                          showCurrencyName: true,
                          showCurrencyCode: true,
                          onSelect: (Currency currency) {
                            print('Select currency: ${currency.name}');
                          },
                        );
                      },
                    ),
                  ],
                ),
                floatingActionButton: FloatingButton(
                    Currency: '17,794 EGP',
                    onPressed: () {
                      context.pushReplacementNamed(Routes.logIn);
                    }),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                body: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceInfo.screenWidth * 0.05,
                        vertical: deviceInfo.screenHeight * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TripHeader(),
                        SizedBox(
                          height: deviceInfo.screenHeight * 0.02,
                        ),
                        Text(
                          'Trip Timeline',
                          style: TextStyles.bold20(deviceInfo, Colors.white)
                              .copyWith(
                                  fontSize: deviceInfo.screenWidth * 0.055),
                        ),
                        SizedBox(
                          height: deviceInfo.screenHeight * 0.01,
                        ),
                        TripTimeline(),
                        SizedBox(
                          height: deviceInfo.screenHeight * 0.03,
                        ),
                        Text(
                          'Baggage Allowance',
                          style: TextStyles.bold20(deviceInfo, Colors.white)
                              .copyWith(
                                  fontSize: deviceInfo.screenWidth * 0.055),
                        ),
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
                          height: deviceInfo.screenHeight * 0.15,
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
