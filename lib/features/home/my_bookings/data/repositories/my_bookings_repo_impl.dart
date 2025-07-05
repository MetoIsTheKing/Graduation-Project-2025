import '../../domain/repositories/my_bookings_repo.dart';
import '../datasources/my_bookings_remote.dart';
import '../models/my_booking_model.dart';

class MyBookingsRepoImpl extends MyBookingsRepo {
  MyBookingsRemote myBookingsRemote;
  MyBookingsRepoImpl({required this.myBookingsRemote});
  @override
  Future<List<MyBookingsModel>> getMyBookings() async {
    return await myBookingsRemote.getMyBookings();
  }

  @override
  Future<bool> cancelFlight(String bookingId) async {
    return await myBookingsRemote.cancelBooking(bookingId);
  }
}
