abstract class BookingRepo {
  Future<Map<String, dynamic>> bookFlight(Map<String, dynamic> requestBody);
  Future<Map<String, dynamic>> createPaymentIntent(
      Map<String, dynamic> requestBody);
  Future<Map<String, dynamic>> checkPaymentStatus(String bookingId);
}
