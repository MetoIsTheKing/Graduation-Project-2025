import 'package:graduation_project_2025/features/auth/data/datasources/users_remote.dart';
import 'package:graduation_project_2025/features/auth/data/models/user_model.dart';
import 'package:graduation_project_2025/features/auth/domain/repositories/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final UsersRemote usersRemote;
  UserRepoImpl(this.usersRemote);
  @override
  Future<Map<String, dynamic>> register(
      String path, Map<String, dynamic> requestbody) async {
    final userResponse = await usersRemote.register(path, requestbody);
    
    final statusCode = userResponse.statusCode;

    final userModel = UserModel.fromJson(userResponse as Map<String, dynamic>);

    final userRegisteredStatus = userModel.success;
    final userRegisteredData = userModel.data;

    return {
      'statusCode': statusCode,
      'success': userRegisteredStatus, 
      'data': userRegisteredData
      };
  }
}
