import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/base_widget.dart';
import 'package:graduation_project_2025/core/shared_components/error_toast.dart';
import 'package:graduation_project_2025/features/home/my_bookings/presentation/cubit/my_bookings_cubit.dart';
import 'package:graduation_project_2025/features/home/my_bookings/presentation/widgets/empty_list_widget.dart';
import 'package:graduation_project_2025/core/shared_components/map_widget.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/my_bookings/presentation/widgets/my_booking_container.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../explore/flights/presentation/widgets/flight_search_results/ticket_tile.dart';

class MyBookingsScreen extends StatelessWidget {
  final ScrollController scrollController;
  const MyBookingsScreen({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo, constraints) {
      // placeholders-------------------------

      return BaseWidget(
        scrollController: scrollController,
        backgroundWidget: MapWidget(
          imageHeight: deviceInfo.screenHeight * 0.3,
          topPadding: deviceInfo.screenHeight * 0.02,
        ),
        foregroundWidget: Padding(
          padding: EdgeInsets.only(top: deviceInfo.screenHeight * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bookings',
                style: TextStyles.bold24(deviceInfo, Colors.white),
              ),
              BlocConsumer<MyBookingsCubit, MyBookingsState>(
                listener: (context, state) {
                  if (state is MyBookingCancelled) {
                    successToast(title: 'Cancelled', description: state.message)
                        .show(context);
                  } else if (state is MyBookingFailedCancel) {
                    errorToast(title: 'Error', description: state.message)
                        .show(context);
                  } else if (state is MyBookingsError) {
                    errorToast(title: 'Error', description: state.message)
                        .show(context);
                  }
                },
                builder: (context, state) {
                  var cubit = MyBookingsCubit.get(context);
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: deviceInfo.screenWidth * 0.04,
                    ),
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: deviceInfo.screenHeight * 0.8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(deviceInfo.screenWidth * 0.08),
                        topRight:
                            Radius.circular(deviceInfo.screenWidth * 0.08),
                      ),
                    ),
                    child: state is MyBookingsLoaded
                        ? state.bookings.isNotEmpty
                            ? ListView.builder(
                                reverse: true,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                clipBehavior: Clip.antiAlias,
                                itemCount: state.bookings.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                          deviceInfo.screenWidth * 0.02,
                                          0,
                                          deviceInfo.screenWidth * 0.02,
                                          deviceInfo.screenHeight * 0.01,
                                        ),
                                        child:
                                            state.bookings[index].status ==
                                                    'confirmed'
                                                ? MyBookingContainer(
                                                    booking:
                                                        state.bookings[index],
                                                    cancelBooking: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            var id = state
                                                                .bookings[index]
                                                                .id;
                                                            return BlocProvider<
                                                                    MyBookingsCubit>.value(
                                                                value: cubit,
                                                                child: BlocBuilder<
                                                                    MyBookingsCubit,
                                                                    MyBookingsState>(
                                                                  builder:
                                                                      (context,
                                                                          state) {
                                                                    return AlertDialog(
                                                                      title:
                                                                          Text(
                                                                        'Cancel Booking',
                                                                        style: TextStyles.medium16(
                                                                            deviceInfo,
                                                                            AppColors.appBlack),
                                                                      ),
                                                                      content:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.warning_amber_outlined,
                                                                            color:
                                                                                AppColors.appRed,
                                                                            size:
                                                                                deviceInfo.screenWidth * 0.1,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                deviceInfo.screenHeight * 0.01,
                                                                          ),
                                                                          Text(
                                                                            'Are you sure you want to cancel this booking?',
                                                                            style:
                                                                                TextStyles.regular14(deviceInfo, AppColors.appBlack),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'No',
                                                                            style:
                                                                                TextStyles.regular14(deviceInfo, AppColors.appBlack),
                                                                          ),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed: state is MyBookingsLoading
                                                                              ? null
                                                                              : () async {
                                                                                  await cubit.cancelBooking(id);
                                                                                  if (!context.mounted) {
                                                                                    return;
                                                                                  }
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                          child: state is MyBookingsLoading
                                                                              ? CircularProgressIndicator(
                                                                                  color: AppColors.appBlue,
                                                                                )
                                                                              : Text(
                                                                                  'Yes',
                                                                                  style: TextStyles.regular14(deviceInfo, AppColors.appRed),
                                                                                ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                ));
                                                          });
                                                    },
                                                  )
                                                : null,
                                      ),
                                    ],
                                  );
                                },
                              )
                            : EmptyListWidget(
                                deviceInfo: deviceInfo,
                                sectionName: 'flights',
                              ).animate().shakeX()
                        : state is MyBookingsLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.appBlue,
                                ),
                              )
                            : state is MyBookingsError
                                ? Center(
                                    child: Text(
                                      state.message,
                                      style: TextStyles.semiBold16(
                                          deviceInfo, Colors.red),
                                    ),
                                  )
                                : Center(
                                    child: EmptyListWidget(
                                      deviceInfo: deviceInfo,
                                      sectionName: 'flights',
                                    ).animate().shakeX(),
                                  ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
