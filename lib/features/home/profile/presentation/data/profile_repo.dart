import 'package:dartz/dartz.dart';
import 'package:graduation_project_2025/features/home/profile/presentation/data/profile_model.dart';
import 'package:graduation_project_2025/features/home/profile/presentation/data/user_profile_remote.dart';

abstract class ProfileRepo {
  Future<Either<String, bool>> resetPassword(String code, String newPassword);
  Future<Either<String, bool>> changePassword(
      String oldPassword, String newPassword);
  Future<Either<String, UserProfileModel>> getUserProfile();
  Future<Either<String, UserProfileModel>> updateUserProfile(
      Map<String, dynamic> data);
}

class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemote remote;
  ProfileRepoImpl(this.remote);

  @override
  Future<Either<String, bool>> resetPassword(
      String code, String newPassword) async {
    try {
      final resp = await remote.resetPassword(code, newPassword);
      return Right(resp.statusCode == 200);
    } catch (e) {
      return Left('Reset password failed');
    }
  }

  @override
  Future<Either<String, bool>> changePassword(
      String oldPassword, String newPassword) async {
    try {
      final resp = await remote.changePassword(oldPassword, newPassword);
      print(resp);
      return Right(resp.statusCode == 200);
    } catch (e) {
      return Left('Change password failed');
    }
  }

  @override
  Future<Either<String, UserProfileModel>> getUserProfile() async {
    try {
      final resp = await remote.getUserProfile();
      return Right(UserProfileModel.fromJson(resp.data));
    } catch (e) {
      return Left('Fetch profile failed');
    }
  }

  @override
  Future<Either<String, UserProfileModel>> updateUserProfile(
      Map<String, dynamic> data) async {
    try {
      final resp = await remote.updateUserProfile(data);
      return Right(UserProfileModel.fromJson(resp.data));
    } catch (e) {
      return Left('Update profile failed');
    }
  }
}
