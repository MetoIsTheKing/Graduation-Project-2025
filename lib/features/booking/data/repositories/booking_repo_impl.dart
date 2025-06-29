import 'package:graduation_project_2025/features/booking/data/datasources/booking_remote.dart';
import 'package:graduation_project_2025/features/booking/domain/repositories/booking_repo.dart';

class BookingRepoImpl implements BookingRepo {
  final BookingRemote bookingRemote;
  BookingRepoImpl(this.bookingRemote);
  @override
  Future<Map<String, dynamic>> bookFlight(
      Map<String, dynamic> requestBody) async {
    return await bookingRemote.bookFlight(requestBody);
  }

  @override
  Future<Map<String, dynamic>> createPaymentIntent(
      Map<String, dynamic> requestBody) async {
    return await bookingRemote.createPaymentIntent(requestBody);
  }
}
