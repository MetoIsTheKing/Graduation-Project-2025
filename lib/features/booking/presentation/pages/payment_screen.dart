import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/curved_appbar.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/home/main_home_screen.dart';

import '../../../../config/theming/text_styles.dart';
import '../../../auth/presentation/widgets/shared_widgets/error_toast.dart';
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
      // We replace the old logic and the immediate success message with this call.
      context.read<BookingCubit>().startPaymentStatusPolling();
    } on StripeException catch (e) {
      // This happens if the user cancels or if the card is declined.
      // The localizedMessage is user-friendly.
      if (e.error.code != FailureCode.Canceled) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Payment Failed: ${e.error.localizedMessage}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred: $e')),
      );
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
          }
          if (state is PaymentIntentFailure) {
            // Handle failure to get the clientSecret
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
          if (state is PaymentPollingSuccess) {
            // THIS is the correct place to show the success message
            // and navigate to the booking confirmation screen.
            successToast(title: 'Success', description: state.message)
                .show(context);
            // Example: Navigator.of(context).pushReplacementNamed('/booking-confirmation');
          }
          if (state is PaymentPollingFailure) {
            // Show the error message from the cubit (e.g., timeout)
            errorToast(title: 'Error', description: state.error).show(context);
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
                child: state is PaymentPollingSuccess
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 100,
                          ),
                          SizedBox(height: 20),
                          Text(
                            state.message,
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
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: AppColors.appBlue,
                          ),
                          SizedBox(height: 20),
                          Text(
                            getIt<BookingCubit>().message ??
                                'Processing payment...',
                            style:
                                TextStyles.medium16(deviceInfo, Colors.black),
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
