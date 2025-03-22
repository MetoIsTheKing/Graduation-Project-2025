import 'package:flutter_dotenv/flutter_dotenv.dart';

class EndPoints {
  static String get fakeUsersBaseUrl => dotenv.env['FAKE_USERS_BASE_URL'] ?? 'https://fake-users-api.com';
}