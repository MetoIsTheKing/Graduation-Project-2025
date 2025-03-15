part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();
}

//----->> sign up
class AuthInitial extends AuthState {}
class SignUpIsLoading extends AuthState {}
class SignUpSuccess extends AuthState {}

class SignUpEmailAlreadyExists extends AuthState {
  final String message;
  SignUpEmailAlreadyExists({required this.message});
}
class SignUpFailed extends AuthState {
  final String message;
  SignUpFailed({required this.message});
}

//----->> verify email
class VerificationStates extends AuthState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  const VerificationStates({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
  });

  VerificationStates copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return VerificationStates(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}
