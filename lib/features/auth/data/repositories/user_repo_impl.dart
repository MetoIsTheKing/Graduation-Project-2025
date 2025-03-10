import 'package:graduation_project_2025/features/auth/data/datasources/users_remote.dart';
import 'package:graduation_project_2025/features/auth/data/models/user_model.dart';
import 'package:graduation_project_2025/features/auth/domain/repositories/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final UsersRemote usersRemote;
  UserRepoImpl(this.usersRemote);

  @override
  Future<Map<String, dynamic>> register(
      Map<String, dynamic> requestBody) async {
    final userResponse = await usersRemote.register(requestBody);
    final statusCode = userResponse['statusCode'];

    if (statusCode == 201) {
      return {
        'statusCode': statusCode,
      };
    } else {
      return {
        'statusCode': statusCode,
      };
    }
  }

  @override
  Future<Map<String, dynamic>> verifyEmail(
      Map<String, dynamic> requestBody) async {
    final verificationResponse = await usersRemote.verifyEmail(requestBody);
    final statusCode = verificationResponse['statusCode'];
    if (statusCode == 201) {
      return {
        'statusCode': statusCode,
        'message': 'Email Verified Successfully',
      };
    } else if (statusCode == 400) {
      return {
        'statusCode': statusCode,
        'message': 'Invalid or Expired Verification Code',
      };
    } else {
      return {
        'statusCode': statusCode,
        'message': 'An Error Occured , Please Try Again Later',
      };
    }
  }
}
