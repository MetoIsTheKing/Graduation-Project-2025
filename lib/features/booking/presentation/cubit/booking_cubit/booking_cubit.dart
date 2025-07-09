import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/core/api/end_points.dart';
import 'package:graduation_project_2025/core/network_clients/abstract_client.dart';
import 'package:graduation_project_2025/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduation_project_2025/features/booking/data/models/one_way_booking_model.dart';
import 'package:graduation_project_2025/features/booking/data/models/round_trip_booking_model.dart';
import 'package:graduation_project_2025/features/booking/domain/repositories/booking_repo.dart';
import 'package:graduation_project_2025/features/booking/presentation/cubit/booking_cubit/booking_state.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/models/flight_model.dart';

import '../../../../../config/dependency_injection/di.dart';
import '../../../../../config/dependency_injection/di_instances.dart';
import '../../../../../core/helpers/my_logger.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepo bookingRepo;
  BookingCubit(this.bookingRepo) : super(BookingInitial());
  static BookingCubit get(context) => BlocProvider.of(context);

  String? bookingRef;
  String? bookingId;
  String? clientSecret;
  String? paymentIntentId;
  double? amount;
  String? currency;
  String? paymentStatus;
  String? bookingStatus;
  String? message;

  // --- Add these variables for polling ---
  Timer? _pollingTimer;
  int _pollingAttempts = 0;
  final int _maxPollingAttempts =
      10; // Timeout after 20 seconds (10 attempts * 2s)
  // ------------------------------------

  void bookFlight(Map<String, dynamic> requestBody) async {
    emit(BookingLoading());
    // Simulate A refresh token call for testing
    // await getIt<DioNetworkClient>(instanceName: DiInstances.dioUserClient)
    //     .refreshToken();

    if (RefreshFailed.value || !(await getIt<AuthCubit>().isLoggedIn())) {
      emit(RefreshTokenExpired());
      return;
    }

    try {
      final response = await bookingRepo.bookFlight(requestBody);
      if (response['statusCode'] != 201) {
        MyLogger.red("Booking failed: ${response['data']['message'][0]}");
        emit(
          BookingFailure("Booking failed: ${response['data']['message'][0]}"),
        );
        return;
      }
      bookingRef = response['data']['data']['bookingRef'];
      bookingId = response['data']['data']['bookingId'];
      message = 'You are almost there\nPlease Proceed to Payment....';

      amount = getIt<FlightSearchQueryParams>().isRoundTrip
          ? getIt<RoundTripBookingModel>().totalPrice
          : getIt<OneWayBookingModel>().totalPrice;
      currency = getIt<FlightSearchQueryParams>().isRoundTrip
          ? getIt<RoundTripBookingModel>().currency
          : getIt<OneWayBookingModel>().currency;

      MyLogger.green(
          "Booking successful: bookingRef = $bookingRef, bookingId = $bookingId");
      emit(BookingSuccess("Flight booked successfully!"));
    } catch (error) {
      MyLogger.red("Booking failed: $error");
      emit(BookingFailure("Failed to book flight: $error"));
    }
  }

  void createPaymentIntent() async {
    emit(PaymentIntentLoading());
    // Simulate A refresh token call for testing

    // await getIt<DioNetworkClient>(instanceName: DiInstances.dioUserClient)
    //     .refreshToken();

    if (RefreshFailed.value) {
      emit(RefreshTokenExpired());
      return;
    }

    message = "Processing payment...";
    var requestBody = {
      "bookingId": bookingId,
      "amount": amount,
      "currency": currency
    };
    try {
      final response = await bookingRepo.createPaymentIntent(requestBody);
      if (response['statusCode'] != 200) {
        MyLogger.red("Payment intent creation failed: ${response['message']}");
        emit(PaymentIntentFailure(
            "Payment intent creation failed: ${response['message']}"));
        return;
      }
      clientSecret = response['data']['data']['clientSecret'];
      paymentIntentId = response['data']['data']['paymentIntentId'];
      MyLogger.green(
          "Payment intent created successfully: clientSecret = $clientSecret, paymentIntentId = $paymentIntentId");

      // throw Exception("Simulated error for testing");
      emit(PaymentIntentSuccess(clientSecret!));
    } catch (error) {
      MyLogger.red("Payment intent creation failed: $error");
      message = "Failed to create payment intent. Please try again.";
      emit(PaymentIntentFailure("Failed to create payment intent"));
    }
  }

  /// Starts the polling process to check for payment status.
  void startPaymentStatusPolling() {
    if (RefreshFailed.value) {
      emit(RefreshTokenExpired());
      return;
    }
    // Cancel any existing timer to be safe
    _pollingTimer?.cancel();
    _pollingAttempts = 0;
    message = "Verifying payment, please wait...";

    emit(PaymentPollingInProgress("Verifying payment, please wait..."));

    // Start a timer that fires every 2 seconds
    _pollingTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _checkPaymentStatus(timer);
    });
  }

  /// Performs a single check of the payment status.
  void _checkPaymentStatus(Timer timer) async {
    _pollingAttempts++;

    // --- Timeout Check ---
    if (_pollingAttempts > _maxPollingAttempts) {
      timer.cancel(); // Stop the timer
      MyLogger.red("Payment status check timed out.");
      message =
          'Verification timed out. Please check your bookings screen or contact support.';
      emit(PaymentPollingFailure(
          "Verification timed out. Please check your bookings screen or contact support."));
      return;
    }
    // ---------------------

    try {
      final response = await bookingRepo.checkPaymentStatus(bookingId!);

      if (response['statusCode'] == 200) {
        final paymentStatus = response['data']['data']['paymentStatus'];

        // --- Success Condition ---
        if (paymentStatus == 'completed') {
          timer.cancel(); // Stop the timer
          bookingStatus = response['data']['data']['status'];
          message = 'Payment successful!';
          // throw Exception("Simulated error for testing");
          emit(PaymentPollingSuccess("Payment confirmed!"));
        }
        // Otherwise, the status is still 'pending', so we do nothing and let the timer fire again.
        // -----------------------
      } else {
        // If the API returns an error, stop polling.
        timer.cancel();
        MyLogger.red("Payment status check failed: ${response['message']}");
        message = 'Failed to verify payment status.';
        emit(PaymentPollingFailure("Payment status check failed:"));
      }
    } catch (error) {
      // If any other error occurs, stop polling.
      timer.cancel();
      MyLogger.red("Payment status check failed: $error");
      message = 'Failed to verify payment status.';
      emit(PaymentPollingFailure("Failed to check payment status: $error"));
    }
  }

  /// Call this method to manually stop the timer if the user navigates away.
  void cancelPayment() {
    message = 'You are almost there\nPlease Proceed to Payment....';
    emit(BookingInitial());
  }

  void startStripe() {
    emit(PaymentStripeInProgress());
  }

  /// Resets the booking state and clears all variables.
  void reset() {
    bookingRef = null;
    bookingId = null;
    clientSecret = null;
    paymentIntentId = null;
    amount = null;
    currency = null;
    paymentStatus = null;
    bookingStatus = null;
    message = null;

    // Cancel any ongoing polling timer
    _pollingTimer?.cancel();
    _pollingAttempts = 0;

    // Emit the initial state to reset the UI
    emit(BookingInitial());
  }

  @override
  Future<void> close() {
    // Ensure the timer is always cancelled when the cubit is closed.
    _pollingTimer?.cancel();
    return super.close();
  }
}
