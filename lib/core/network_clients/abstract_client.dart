import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graduation_project_2025/config/token_manager.dart';
import 'package:graduation_project_2025/core/helpers/my_logger.dart';

//TODO: needed to be abstracted??
class DioNetworkClient {
  late Dio dio;

  DioNetworkClient(String baseUrl) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(seconds: 20),
        sendTimeout: Duration(seconds: 20),
        receiveTimeout: Duration(seconds: 20),
        headers: {
          'Content-Type': 'application/json',
          //authriztion header
        },
        validateStatus: (status) {
          return status != null && (status < 500);
          // Accepts any response with status < 500, including 409
        },
      ),
    );

    //TODO: remember to remove interceptors
    // Add logging interceptor for debugging
    dio.interceptors.add(LogInterceptor(
      request: true,
      error: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));

    dio.interceptors.add(_authInterceptor());
  }

  Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add access token to headers
        final accessToken = await TokenManager.getAccessToken();
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(options);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) async {
        if (error.response?.statusCode == 401) {
          // Token expired, attempt to refresh
          MyLogger.red('Token expired, attempting to refresh...');
          final refreshed = await refreshToken();
          if (refreshed) {
            // Retry the original request with the new token
            final options = error.requestOptions;
            final accessToken = await TokenManager.getAccessToken();
            options.headers['Authorization'] = 'Bearer $accessToken';
            try {
              final response = await dio.fetch(options);
              return handler.resolve(response);
            } catch (e) {
              return handler.reject(error);
            }
          } else {
            MyLogger.red('Token refresh failed, user needs to log in again.');
          }
        }
        return handler.reject(error);
      },
    );
  }

  // Refresh token logic
  Future<bool> refreshToken() async {
    final refreshToken = await TokenManager.getRefreshToken();
    if (refreshToken == null) return false;

    try {
      final refreshUrl =
          '${dotenv.env['FAKE_USERS_BASE_URL']}/refresh-token'; // Adjust endpoint as needed
      final response = await Dio().post(
        refreshUrl,
        data: {'refresh_token': refreshToken},
      );

      // throw Exception('Token refresh failed'); // For testing purposes

      if (response.statusCode == 201) {
        // Reset the refresh failed flag
        RefreshFailed.value = false;
        final newAccessToken = response.data['access_token'];
        final newRefreshToken =
            response.data['refresh_token']; // Optional, if provided
        // Save the new tokens
        await TokenManager.saveAccessTokens(newAccessToken);
        if (newRefreshToken != null) {
          await TokenManager.saveRefreshTokens(newRefreshToken);
        }
        //?? we need to validate refresh token , if expired we should logout
        return true;
      } else {
        throw Exception(
          'Failed to refresh token: ${response.statusCode} - ${response.statusMessage}',
        );
      }
    } catch (e) {
      // Handle token refresh failure
      RefreshFailed.value = true;
      MyLogger.red('Token refresh failed: $e');
      return false;
    }
  }

  // Factory constructors to create separate instances
  // factory DioNetworkClient.posts() => DioNetworkClient(RealEndPoints.realPostsBaseUrl);

  // Generic GET request with token and query parameters
  Future<Response> get(
    String path, {
    // Add token parameter
    Map<String, dynamic>? queryParameters,
    bool isProtected = false,
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            if (isProtected)
              'Authorization': 'Bearer ${await TokenManager.getAccessToken()}',
          },
        ),
      );
      return response;
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  // Generic POST request with token and data
  Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
    bool isProtected = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        options: Options(
          headers: {
            if (isProtected)
              'Authorization': 'Bearer ${await TokenManager.getAccessToken()}',
          },
        ),
      );
      return response;
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  // Generic PUT request with token and data
  Future<Response> put(
    String path, {
    // Add token parameter
    Map<String, dynamic>? data,
    bool isProtected = false,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        options: Options(
          headers: {
            if (isProtected)
              'Authorization': 'Bearer ${await TokenManager.getAccessToken()}',
          },
        ),
      );
      return response;
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  // Generic PATCH request with token and data
  Future<Response> patch(
    String path, {
    Map<String, dynamic>? data,
    bool isProtected = false,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: data,
        options: Options(
          headers: {
            if (isProtected)
              'Authorization': 'Bearer ${await TokenManager.getAccessToken()}',
          },
        ),
      );
      return response;
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  // Generic DELETE request with token
  Future<Response> delete(
    String path,
  ) async {
    try {
      final response = await dio.delete(
        path, // Add token dynamically
      );
      return response;
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  // Error handling method
  //TODO: remove kDebugMode
  void handleError(Object error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          if (kDebugMode) {
            print('Connection timeout');
          }
          break;
        case DioExceptionType.sendTimeout:
          if (kDebugMode) {
            print('Send timeout');
          }
          break;
        case DioExceptionType.receiveTimeout:
          if (kDebugMode) {
            print('Receive timeout');
          }
          break;
        case DioExceptionType.badResponse:
          if (kDebugMode) {
            print(
                'Response error: ${error.response?.statusCode} - ${error.response?.statusMessage}');
          }
          break;
        case DioExceptionType.cancel:
          if (kDebugMode) {
            print('Request canceled');
          }
          break;
        case DioExceptionType.unknown:
          if (kDebugMode) {
            print('Unexpected error: ${error.message}');
          }
          break;
        default:
          if (kDebugMode) {
            print('Unhandled DioExceptionType: ${error.type}');
          }
          break;
      }
    } else {
      if (kDebugMode) {
        print('Unknown error: $error');
      }
    }
  }
}

// a flag to indicate if a refresh operation has failed
abstract class RefreshFailed {
  static bool value = false;
}
