import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  static const _storage = FlutterSecureStorage();

  // Keys for storing tokens
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  // Save tokens
  static Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  // Retrieve access token
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  // Retrieve refresh token
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  // Clear tokens (e.g., on logout)
  static Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }
}