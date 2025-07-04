import 'package:dio/dio.dart';
import 'package:graduation_project_2025/core/api/end_points.dart';
import 'package:graduation_project_2025/core/network_clients/abstract_client.dart';

class ChatBotClient extends DioNetworkClient {
  ChatBotClient() : super(EndPoints.chatBot) {
    dio.options.baseUrl = EndPoints.chatBot;
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
