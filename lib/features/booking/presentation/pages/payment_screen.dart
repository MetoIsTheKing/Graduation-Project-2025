import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/core/helpers/my_logger.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/curved_appbar.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/main_home_screen.dart';

import '../../../../config/routing/auth_navigation_state.dart';
import '../../../../config/routing/routes.dart';
import '../../../../config/theming/text_styles.dart';
import '../../../../core/shared_components/error_toast.dart';
import '../cubit/booking_cubit/booking_cubit.dart';
import '../cubit/booking_cubit/booking_state.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  // This function will contain the Stripe logic
  Future<void> _startPayment(BuildContext context, String clientSecret) async {
    try {
      // change the state
      context.read<BookingCubit>().startStripe();
      // 1. Initialize the payment sheet (remains the same)
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Flight Booking App', // Your company name
          paymentIntentClientSecret: clientSecret,
        ),
      );

      // 2. Present the payment sheet to the user (remains the same)
      await Stripe.instance.presentPaymentSheet();

      // This check is good practice, keep it.
      if (!context.mounted) return;

      // 3. IMPORTANT: Start the polling process with your backend.
      // This line is only reached if payment was submitted (not necessarily successful yet)
      context.read<BookingCubit>().startPaymentStatusPolling();
    } on StripeException catch (e) {
      // This block is executed for any Stripe-related error, including cancellation.

      if (e.error.code == FailureCode.Canceled) {
        // --- THIS IS THE CANCELLATION CASE ---
        // The user closed the payment sheet without paying.
        // We call a method on the cubit to reset the state gracefully.
        if (context.mounted) {
          context.read<BookingCubit>().cancelPayment();
        }
      } else {
        // This is for other errors, like a declined card.
        // The localizedMessage is user-friendly.
        if (context.mounted) {
          MyLogger.red('Payment Failed: ${e.error.localizedMessage}');
        }
      }
    } catch (e) {
      if (context.mounted) {
        MyLogger.red('An unexpected error occurred: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo, constraints) {
      return BlocConsumer<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state is PaymentIntentSuccess) {
            // Once we have the clientSecret, start the payment process
            _startPayment(context, getIt<BookingCubit>().clientSecret!);
          } else if (state is PaymentIntentFailure) {
            // Handle failure to get the clientSecret
          } else if (state is PaymentPollingSuccess) {
            // THIS is the correct place to show the success message
            // and navigate to the booking confirmation screen.
            successToast(title: 'Success', description: state.message)
                .show(context);
            // Example: Navigator.of(context).pushReplacementNamed('/booking-confirmation');
          } else if (state is PaymentPollingFailure) {
            // Show the error message from the cubit (e.g., timeout)
            errorToast(title: 'Error', description: state.error).show(context);
          } else if (state is RefreshTokenExpired) {
            errorToast(
              title: 'Session Expired',
              description: 'Please log in again.',
            ).show(context);
            getIt<AuthNavigationState>().setRedirectRoute(Routes.paymentScreen);
            Navigator.of(context).pushNamed(Routes.logIn);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CurvedAppbar(
              onBack: () => context.pop(),
              backgroundColor: AppColors.appBlue,
              titleWidget: Text(
                'Payment',
                style: TextStyles.medium20(deviceInfo, Colors.white),
              ),
              backButtonColor: Colors.white,
            ),
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: state is PaymentPollingSuccess,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: deviceInfo.screenHeight * 0.2,
                          ),
                          SizedBox(height: 20),
                          Text(
                            getIt<BookingCubit>().message ?? '',
                            style:
                                TextStyles.medium16(deviceInfo, Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          CustomRoundedButton(
                            deviceInfo: deviceInfo,
                            label: 'Continue to Home',
                            backgroundColor: AppColors.appGreen,
                            onPressed: () {
                              getIt<BookingCubit>().reset();

                              // Navigate to the home screen or booking confirmation
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MainHomeScreen()), // The new page to show
                                (Route<dynamic> route) =>
                                    false, // The predicate to remove all previous routes
                              );
                            },
                            textColor: Colors.white,
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: state is BookingLoading ||
                          state is PaymentIntentLoading ||
                          state is PaymentPollingInProgress ||
                          state is PaymentStripeInProgress,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: AppColors.appBlue,
                          ),
                          SizedBox(height: deviceInfo.screenHeight * 0.02),
                          Text(
                            getIt<BookingCubit>().message ??
                                'Processing payment...',
                            style:
                                TextStyles.medium16(deviceInfo, Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: state is BookingInitial ||
                          state is BookingSuccess ||
                          state is RefreshTokenExpired,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.payment,
                            color: AppColors.appYellow,
                            size: deviceInfo.screenHeight * 0.2,
                          ),
                          SizedBox(height: deviceInfo.screenHeight * 0.05),
                          Text(
                            getIt<BookingCubit>().message ??
                                'Please proceed to payment',
                            style:
                                TextStyles.medium16(deviceInfo, Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: deviceInfo.screenHeight * 0.05),
                          CustomRoundedButton(
                            deviceInfo: deviceInfo,
                            label: 'Pay Now',
                            backgroundColor: AppColors.appBlue,
                            onPressed: () {
                              // Trigger the payment intent creation
                              context
                                  .read<BookingCubit>()
                                  .createPaymentIntent();
                            },
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: state is BookingFailure ||
                          state is PaymentIntentFailure ||
                          state is PaymentPollingFailure,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: AppColors.appRed,
                            size: deviceInfo.screenHeight * 0.2,
                          ),
                          SizedBox(height: deviceInfo.screenHeight * 0.05),
                          Text(
                            getIt<BookingCubit>().message ??
                                'An error occurred during payment',
                            style:
                                TextStyles.medium16(deviceInfo, Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: deviceInfo.screenHeight * 0.05),
                          CustomRoundedButton(
                            deviceInfo: deviceInfo,
                            label: 'Pay Now',
                            backgroundColor: AppColors.appBlue,
                            onPressed: () {
                              // Trigger the payment intent creation
                              context
                                  .read<BookingCubit>()
                                  .createPaymentIntent();
                            },
                            textColor: Colors.white,
                          ),
                          CustomRoundedButton(
                            deviceInfo: deviceInfo,
                            label: 'Go Home',
                            backgroundColor: AppColors.appRed,
                            onPressed: () {
                              getIt<BookingCubit>().reset();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainHomeScreen()),
                                (Route<dynamic> route) =>
                                    false, // The predicate to remove all previous routes
                              );
                            },
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
