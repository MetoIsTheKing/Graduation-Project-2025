import 'package:dio/dio.dart';
import 'package:graduation_project_2025/core/network_clients/abstract_client.dart';

abstract class UsersRemote {
  Future<Map<String, dynamic>> register(Map<String, dynamic> requestbody,
      {String? path});
  Future<Map<String, dynamic>> logIn(Map<String, dynamic> requestbody,
      {String? path});
  Future<Map<String, dynamic>> verifyEmail(Map<String, dynamic> requestbody,
      {String? path});
  Future<Response> resendVerification(
      String path, Map<String, dynamic> requestbody);
  //TODO: to be continued
}

class UsersRemoteImpl implements UsersRemote {
  final DioNetworkClient fakeUsersClient;
  UsersRemoteImpl({required this.fakeUsersClient});

  // POST/register
  @override
  Future<Map<String, dynamic>> register(Map<String, dynamic> requestbody,
      {String? path}) async {
    try {
      final response = await fakeUsersClient.post(
        'register',
        data: requestbody,
      );
      // print('response ---------->: ${response}');
      return {
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(e);
    }
  }

  @override
  Future<Map<String, dynamic>> logIn(Map<String, dynamic> requestbody,
      {String? path}) async {
    try {
      final response = await fakeUsersClient.post(
        'login',
        data: requestbody,
      );
      return {
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(e);
    }
  }

  @override
  Future<Map<String, dynamic>> verifyEmail(Map<String, dynamic> requestbody,
      {String? path}) async {
    try {
      final response = await fakeUsersClient.post(
        'verify-email',
        data: requestbody,
      );
      return {
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(e);
    }
  }

  @override
  Future<Response> resendVerification(
      String path, Map<String, dynamic> requestbody) {
    // TODO: implement resendVerification
    throw UnimplementedError();
  }
}
