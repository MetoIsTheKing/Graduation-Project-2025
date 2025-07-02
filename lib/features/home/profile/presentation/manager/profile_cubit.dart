import 'package:bloc/bloc.dart';
import 'package:graduation_project_2025/features/home/profile/presentation/data/profile_repo.dart';
import 'package:graduation_project_2025/features/home/profile/presentation/manager/profile_state.dart';

class ProfileCubit extends Cubit<UserState> {
  final ProfileRepo repo;
  ProfileCubit(this.repo) : super(UserInitial());

  Future<void> resetPassword(String code, String newPassword) async {
    emit(UserLoading());
    final result = await repo.resetPassword(code, newPassword);
    result.fold(
        (l) => emit(UserError(l)), (r) => emit(UserSuccess('Password reset')));
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    emit(UserLoading());
    final result = await repo.changePassword(oldPassword, newPassword);
    result.fold((l) => emit(UserError(l)),
        (r) => emit(UserSuccess('Password changed')));
  }

  Future<void> getUserProfile() async {
    emit(UserLoading());
    final result = await repo.getUserProfile();
    result.fold((l) => emit(UserError(l)), (r) => emit(UserProfileLoaded(r)));
  }

  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    emit(UserLoading());
    final result = await repo.updateUserProfile(data);
    print(result);
    result.fold((l) => emit(UserError(l)), (r) => emit(UserProfileLoaded(r)));
  }
}
