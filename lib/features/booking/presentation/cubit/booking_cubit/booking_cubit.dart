import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/features/booking/domain/repositories/booking_repo.dart';
import 'package:graduation_project_2025/features/booking/presentation/cubit/booking_cubit/booking_state.dart';

import '../../../../../core/helpers/my_logger.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepo bookingRepo;
  BookingCubit(this.bookingRepo) : super(BookingInitial());
  static BookingCubit get(context) => BlocProvider.of(context);

  String? bookingRef;
  String? bookingId;

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
      MyLogger.green(
          "Booking successful: bookingRef = $bookingRef, bookingId = $bookingId");
      emit(BookingSuccess("Flight booked successfully!"));
    } catch (error) {
      MyLogger.red("Booking failed: $error");
      emit(BookingFailure("Failed to book flight: $error"));
    }
  }
}
