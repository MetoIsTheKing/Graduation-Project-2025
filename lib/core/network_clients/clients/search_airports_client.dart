import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:graduation_project_2025/core/api/end_points.dart';
import 'package:graduation_project_2025/core/network_clients/abstract_client.dart';


class AmadeusApiClient extends DioNetworkClient {
  final String apiKey;
  final String apiSecret;
  String? _currentToken;
  DateTime? _tokenExpiry;
  
  static const int _tokenExpiryBufferSeconds = 60;

  AmadeusApiClient({required this.apiKey, required this.apiSecret})
      : super(EndPoints.searchAirportsBaseUrl) {
    dio.options.baseUrl = EndPoints.searchAirportsBaseUrl;
    
    // Initial headers
    dio.options.headers = {
      'Content-Type': 'application/json',
    };

    // Add logging interceptor
    dio.interceptors.add(LogInterceptor(
      request: true,
      error: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));

    // Add auth interceptor
    _addAuthInterceptor();
  }

  void _addAuthInterceptor() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Skip token for the token endpoint itself
          if (options.path == '/security/oauth2/token') {
            return handler.next(options);
          }

          // Get valid token (either cached or new)
          final token = await _getValidToken();
          options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
        onError: (error, handler) async {
          // Handle 401 errors by refreshing token and retrying
          if (error.response?.statusCode == 401) {
            try {
              // Clear expired token
              _currentToken = null;
              _tokenExpiry = null;
              
              // Get new token
              final token = await _getValidToken();
              
              // Update the request header
              error.requestOptions.headers['Authorization'] = 'Bearer $token';
              
              // Create new request with the same options
              final opts = Options(
                method: error.requestOptions.method,
                headers: error.requestOptions.headers,
              );
              
              // Retry the request
              final response = await dio.request<dynamic>(
                error.requestOptions.path,
                data: error.requestOptions.data,
                queryParameters: error.requestOptions.queryParameters,
                options: opts,
              );
              
              return handler.resolve(response);
            } catch (e) {
              return handler.reject(error);
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<String> _getValidToken() async {
    // Return cached token if it exists and isn't expired
    if (_currentToken != null && 
        _tokenExpiry != null && 
        _tokenExpiry!.isAfter(DateTime.now())) {
      return _currentToken!;
    }

    // Otherwise, fetch new token
    return await _refreshToken();
  }

  Future<String> _refreshToken() async {
  try {
    // Create a new Dio instance without interceptors to avoid infinite loops
    final tokenDio = Dio(BaseOptions(
      baseUrl: dio.options.baseUrl,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    ));

    final response = await tokenDio.post<String>(
      '/security/oauth2/token',
      data: {
        'grant_type': 'client_credentials',
        'client_id': apiKey,
        'client_secret': apiSecret,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );

    // Parse the response safely
    final responseData = response.data;
    if (responseData == null) {
      throw Exception('Empty response from token endpoint');
    }

    final jsonResponse = jsonDecode(responseData) as Map<String, dynamic>;
    final token = jsonResponse['access_token'] as String?;
    final expiresIn = jsonResponse['expires_in'] as int?;

    if (token == null) {
      throw Exception('No access token in response');
    }

    _currentToken = token;
    _tokenExpiry = DateTime.now().add(
      Duration(seconds: (expiresIn ?? 3600) - _tokenExpiryBufferSeconds),
    );

    return token;
  } catch (e) {
    _currentToken = null;
    _tokenExpiry = null;
    throw Exception('Failed to refresh token: $e');
  }
}
}