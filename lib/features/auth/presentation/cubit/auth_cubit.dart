import 'package:bloc/bloc.dart';
import 'package:graduation_project_2025/features/auth/domain/repositories/user_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepo userRepo;
  AuthCubit(this.userRepo) : super(AuthInitial());

  //TODO: do i need try & catch ????
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

  Future<void> verifyEmail(Map<String, dynamic> requestbody) async {
    emit(VerificationStates(
      isLoading: true,
      isSuccess: false,
      error: null,
    ));
    print('state now is Loading');

    try {
      final response = await userRepo.verifyEmail(requestbody);
      if (response['statusCode'] == 201) {
        emit(VerificationStates(
          isLoading: false,
          isSuccess: true,
          error: null,
        ));
        print('state now is Success');
        return;
      } else if (response['statusCode'] == 400) {
        emit(VerificationStates(
          isLoading: false,
          isSuccess: false,
          error: 'Invalid or Expired Verification Code',
        ));
        print('state now is Invalid or Expired Verification Code');
        return;
      } else {
        emit(VerificationStates(
          isLoading: false,
          isSuccess: false,
          error: 'An Error Occured , Please Try Again Later',
        ));
        print('state now is An Error Occured , Please Try Again Later');
      }
    } catch (e) {
      emit(VerificationStates(
        isLoading: false,
        isSuccess: false,
        error: e.toString(),
      ));
      print('state now is Unknown Error');
    }
  }

  Future<void> login(Map<String, dynamic> requestbody) async {
    emit(LoginIsLoading());
    print('state now is : $state');
    try {
      final response = await userRepo.login(requestbody);

      if (response['statusCode'] == 201) {
        emit(
          LoginSuccess(
            accessToken: response['accessToken'],
            refreshToken: response['refreshToken'],
          ),
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
        message: e.toString(),
      ));
      print('state now is in catch : $state');
    }
  }
}
