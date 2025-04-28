import 'package:dio/dio.dart';
import 'package:graduation_project_2025/core/api/end_points.dart';
import 'package:graduation_project_2025/core/network_clients/abstract_client.dart';

class FakeUsersClient extends DioNetworkClient {
  @override
  FakeUsersClient() : super(EndPoints.fakeUsersBaseUrl) {
    dio.options.baseUrl = EndPoints.fakeUsersBaseUrl;
    dio.options.headers = {
      'Content-Type': 'application/json',
    
      
    }; // Replace with your Fake base URL
    dio.interceptors.add(LogInterceptor(
      request: true,
      error: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));
  }
}
