import 'package:bloc/bloc.dart';
import 'package:graduation_project_2025/features/auth/domain/repositories/user_repo.dart';


part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepo userRepo;
  AuthCubit(this.userRepo) : super(AuthInitial());

  Future<void> register(Map<String, dynamic> requestbody) async {
    emit(AuthSignUpIsLoading());
    try {
      final response = await userRepo.register(requestbody);
      if (response['statusCode'] == 201) {
        emit(AuthSignUpSuccess(
          data: response['data'],
          statusCode: response['statusCode'],
          success: response['success'],
        ));
      } else {
        emit(AuthSignUpFailed(
          message: 'not success',
          statusCode: response['statusCode'],
        ));
      }
    } catch (e) {
      emit(AuthSignUpFailed(
        message: e.toString(),
      ));
    }
  }
}
