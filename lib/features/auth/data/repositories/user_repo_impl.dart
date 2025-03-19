import 'package:graduation_project_2025/features/auth/data/datasources/users_remote.dart';
import 'package:graduation_project_2025/features/auth/domain/repositories/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final UsersRemote usersRemote;
  UserRepoImpl(this.usersRemote);

  @override
  Future<Map<String, dynamic>> register(
      Map<String, dynamic> requestBody) async {
    return await usersRemote.register(requestBody);
  }

  @override
  Future<Map<String, dynamic>> verifyEmail(
      Map<String, dynamic> requestBody) async {
   return await usersRemote.verifyEmail(requestBody);
  }

  @override
  Future<Map<String, dynamic>> login(Map<String, dynamic> requestbody) async {
   return await usersRemote.logIn(requestbody);
  }

  @override
  Future<Map<String, dynamic>> resendVerification(
      Map<String, dynamic> requestbody) async {
    return await usersRemote.resendVerification(requestbody);
  }
}
