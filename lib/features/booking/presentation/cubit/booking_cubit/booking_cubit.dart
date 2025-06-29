import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/features/booking/data/models/one_way_booking_model.dart';
import 'package:graduation_project_2025/features/booking/data/models/round_trip_booking_model.dart';
import 'package:graduation_project_2025/features/booking/domain/repositories/booking_repo.dart';
import 'package:graduation_project_2025/features/booking/presentation/cubit/booking_cubit/booking_state.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/models/flight_model.dart';

import '../../../../../config/dependency_injection/di.dart';
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

  void bookFlight(Map<String, dynamic> requestBody) async {
    emit(BookingLoading());
    try {
      final response = await bookingRepo.bookFlight(requestBody);
      if (response['statusCode'] != 201) {
        MyLogger.red("Booking failed: ${response['message']}");
        emit(BookingFailure("Booking failed: ${response['message']}"));
        return;
      }
      bookingRef = response['data']['data']['bookingRef'];
      bookingId = response['data']['data']['bookingId'];

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
      emit(PaymentIntentSuccess(clientSecret!));
    } catch (error) {
      MyLogger.red("Payment intent creation failed: $error");
      emit(PaymentIntentFailure("Failed to create payment intent: $error"));
    }
  }
}
