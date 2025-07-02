import 'package:dio/dio.dart';
import 'package:graduation_project_2025/core/network_clients/abstract_client.dart';

abstract class ProfileRemote {
  Future<Response> resetPassword(String code, String newPassword);
  Future<Response> changePassword(String oldPassword, String newPassword);
  Future<Response> getUserProfile();
  Future<Response> updateUserProfile(Map<String, dynamic> data);
}

class ProfileRemoteImpl implements ProfileRemote {
  final DioNetworkClient client;
  ProfileRemoteImpl(this.client);

  @override
  Future<Response> resetPassword(String code, String newPassword) {
    return client.post('/users/reset-password', data: {
      'code': code,
      'newPassword': newPassword,
    });
  }

  @override
  Future<Response> changePassword(String oldPassword, String newPassword) {
    return client.put('/users/change-password',
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
        isProtected: true);
  }

  @override
  Future<Response> getUserProfile() {
    return client.get('/users/profile', isProtected: true);
  }

  @override
  Future<Response> updateUserProfile(Map<String, dynamic> data) {
    return client.patch('/users/profile', data: data, isProtected: true);
  }
}
