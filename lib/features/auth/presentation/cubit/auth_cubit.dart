import 'package:bloc/bloc.dart';
import 'package:graduation_project_2025/features/auth/domain/repositories/user_repo.dart';
import 'dart:developer';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepo userRepo;
  AuthCubit(this.userRepo) : super(AuthInitial());

  Future<void> register(Map<String, dynamic> requestbody) async {
    emit(SignUpIsLoading());
    print('state now is : $state');
    try {
      final response = await userRepo.register(requestbody);
      if (response['statusCode'] == 201) {
        emit(SignUpSuccess());
        print('state now is : $state');
      } else if (response['statusCode'] == 409) {
        emit(SignUpEmailAlreadyExists(
          message: 'Email Already Exists',
        ));
        print('state now is : $state');
      } else {
        emit(SignUpFailed(
          message: 'An Error Occured , Please Try Again Later',
        ));
        print('state now is in try : $state');
      }
    } catch (e) {
      emit(SignUpFailed(
        message: e.toString(),
      ));
      print('state now is in catch : $state');
    }
  }

  Future<void> login(Map<String, dynamic> requestbody) async {
    emit(LoginIsLoading());
    print('state now is : $state');
    try {
      final response = await userRepo.login(requestbody);

      if (response['statusCode'] == 201) {
        emit(
          LoginSuccess(),
        );
        print('state now is : $state');
        print('response is from Cubit -------------> : $response');
      } else if (response['statusCode'] == 401) {
        emit(LoginFailed(
          message: 'Invalid Email or Password',
        ));
        print('state now is : $state');
      } else {
        emit(LoginFailed(
          message: 'An Error Occured , Please Try Again Later',
        ));
        print('state now is in try : $state');
      }
    } catch (e) {
      emit(LoginFailed(
        message: 'Something Went Wrong',
      ));
      log(e.toString());
      print('state now is in catch : $state');
    }
  }

  Future<void> verifyEmail(Map<String, dynamic> requestBody) async {
    await _handleVerification(
        requestBody, userRepo.verifyEmail, VerificationStates.new);
  }

  Future<void> resendVerification(Map<String, dynamic> requestBody) async {
    await _handleVerification(
        requestBody, userRepo.resendVerification, ResendVerificationStates.new);
  }

  Future<void> _handleVerification(
    Map<String, dynamic> requestBody,
    Future<Map<String, dynamic>> Function(Map<String, dynamic>) repoMethod,
    AuthState Function({bool isLoading, bool isSuccess, String? error})
        stateConstructor,
  ) async {
    emit(stateConstructor(isLoading: true));
    try {
      final response = await repoMethod(requestBody);
      if (response['statusCode'] == 201 || response['statusCode'] == 200) {
        log('in try success state ${state.toString()}');
        emit(stateConstructor(isLoading: false, isSuccess: true));
      } else if (response['statusCode'] == 400) {
        log('in try 400 code state ${state.toString()}');

        emit(stateConstructor(
            isLoading: false, error: 'Invalid or Expired Verification Code'));
      } else {
        log('in try error state ${state.toString()}');

        emit(stateConstructor(
            isLoading: false,
            error: 'An Error Occurred, Please Try Again Later'));
      }
    } catch (e) {
      log(e.toString());

      emit(stateConstructor(isLoading: false, error: e.toString()));
    }
  }

  Future<void> requestResetPassword(Map<String, dynamic> requestbody) async {
    emit(RequestPassResetIsLoading());
    print('state now is : $state');
    try {
      final response = await userRepo.requestResetPassword(requestbody);
      if (response['statusCode'] == 201) {
        emit(RequestPassResetSuccess());
        print('state now is : $state');
      } else {
        emit(RequestPassResetFailed(
          message: 'An Error Occured , Please Try Again Later',
        ));
        print('state now is in try : $state');
      }
    } catch (e) {
      emit(RequestPassResetFailed(
        message: e.toString(),
      ));
      print('state now is in catch : $state');
    }
  }

  Future<void> resetPassword(Map<String, dynamic> requestbody) async {
    emit(RequestPassResetIsLoading());
    print('state now is : $state');
    try {
      final response = await userRepo.resetPassword(requestbody);
      if (response['statusCode'] == 201) {
        emit(ResetPassSuccess());
        print('state now is : $state');
      } else {
        emit(ResetPassFailed(
          message: 'An Error Occured , Please Try Again Later',
        ));
        print('state now is in try : $state');
      }
    } catch (e) {
      emit(ResetPassFailed(
        message: e.toString(),
      ));
      print('state now is in catch : $state');
    }
  }
}
