
import 'package:graduation_project_2025/config/token_manager.dart';
import 'package:graduation_project_2025/core/network_clients/abstract_client.dart';

abstract class UsersRemote {
  Future<Map<String, dynamic>> register(Map<String, dynamic> requestbody,
      {String? path});
  Future<Map<String, dynamic>> logIn(Map<String, dynamic> requestbody,
      {String? path});
  Future<Map<String, dynamic>> verifyEmail(Map<String, dynamic> requestbody,);
  Future<Map<String, dynamic>> resendVerification(
Map<String, dynamic> requestbody);
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
      return {
        'statusCode': response.statusCode,
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
      if (response.statusCode == 201) {
        final accessToken = response.data['data']['accessToken'];
        final refreshToken = response.data['data']['refreshToken'];
        // this the token caching
        await TokenManager.saveTokens(accessToken, refreshToken);
        return {
          'statusCode': response.statusCode,
          'accessToken': accessToken,
          'refreshToken': refreshToken,
        };
      } else {
        return {
          'statusCode': response.statusCode,
        };
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(e);
    }
  }

  @override
  Future<Map<String, dynamic>> verifyEmail(Map<String, dynamic> requestbody
      ) async {
    return await verificationSend(requestbody, 'verify-email');
  }


  @override
  Future<Map<String, dynamic>> resendVerification(
      Map<String, dynamic> requestbody) async {
    return await verificationSend(requestbody , 'resend-verification');
  }
  Future<Map<String, dynamic>> verificationSend(Map<String, dynamic> requestbody , String path) async {
     try {
      final response = await fakeUsersClient.post(
        path,
        data: requestbody,
      );
      return {
        'statusCode': response.statusCode,
      };
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(e);
    }
  }
}
