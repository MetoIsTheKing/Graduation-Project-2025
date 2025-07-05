import 'package:graduation_project_2025/features/home/my_bookings/data/models/my_booking_model.dart';

abstract class MyBookingsRepo {
  Future<List<MyBookingsModel>> getMyBookings();

  Future<bool> cancelFlight(String bookingId);
}
