import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../core/network_clients/abstract_client.dart';

class TokenManager {
  static const _storage = FlutterSecureStorage();

  // Keys for storing tokens
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userId = 'user_id';

  // Save tokens
  static Future<void> saveAccessTokens(
    String accessToken,
  ) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
  }

  static Future<void> saveRefreshTokens(
    String refreshToken,
  ) async {
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
    // Reset the refresh failed state, as a new token has been registered
    RefreshFailed.value = false;
  }

  static Future<void> saveUserId(String userId) async {
    await _storage.write(key: _userId, value: userId);
  }

  // Retrieve access token
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  // Retrieve refresh token
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  // Retrieve user ID
  static Future<String?> getUserId() async {
    
    final userId = await _storage.read(key: _userId);
    if (userId == null || userId.isEmpty) {
      return "guest";
    }
    return userId;
  }

  // Clear tokens (e.g., on logout)
  static Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _userId);
  }
}
