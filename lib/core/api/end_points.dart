import 'package:flutter_dotenv/flutter_dotenv.dart';

class EndPoints {
  static String get fakeUsersBaseUrl =>
      dotenv.env['FAKE_USERS_BASE_URL'] ?? 'https://fake-users-api.com';
  static String get searchAirportsBaseUrl =>
      dotenv.env['AIRPORTS_BASE_URL'] ?? "fake-airports-api.com";

  static String get bookFlight => "booking/book-flight";
  static String get createPaymentIntent => "payment/create-payment-intent";
  static String get checkPaymentStatus => "payment/status/";
  static String get cancelFlight => "booking/cancel-flight";
  static String get getMyBookings => "booking/my-bookings";
  static String cancelBooking(String id) => "/booking/$id/cancel";
  static String get chatBot =>
      dotenv.env['CHAT_BOT'] ?? "https://chatbot-api.com";
}
