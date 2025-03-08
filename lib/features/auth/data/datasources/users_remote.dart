import 'package:dio/dio.dart';
import 'package:graduation_project_2025/core/network_clients/clients/fake_users_client.dart';

abstract class UsersRemote {
  Future<Response> register(String path, Map<String, dynamic> requestbody);
  Future<Response> logIn(String path, Map<String, dynamic> requestbody);
  Future<Response> verifyEmail(String path, Map<String, dynamic> requestbody);
  Future<Response> resendVerification(
      String path, Map<String, dynamic> requestbody);
  //TODO: to be continued
}

class UsersRemoteImpl implements UsersRemote {
  final FakeUsersClient fakeUsersClient;
  UsersRemoteImpl({required this.fakeUsersClient});

  // POST/register
  @override
  Future<Response> register(
      String path, Map<String, dynamic> requestbody) async {
    try {
      final response = await fakeUsersClient.post(
        path,
        data: requestbody,
      );
      return response;
    } on DioException catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(e);
    }
  }
  
  @override
  Future<Response> logIn(String path, Map<String, dynamic> requestbody) {
    // TODO: implement logIn
    throw UnimplementedError();
  }
  
  @override
  Future<Response> resendVerification(String path, Map<String, dynamic> requestbody) {
    // TODO: implement resendVerification
    throw UnimplementedError();
  }
  
  @override
  Future<Response> verifyEmail(String path, Map<String, dynamic> requestbody) {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }
}
