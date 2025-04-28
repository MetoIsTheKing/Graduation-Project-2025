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

//----->> login
class LoginInitial extends AuthState {}

class LoginIsLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailed extends AuthState {
  final String message;
  LoginFailed({required this.message});
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

//----->> resend verification code
class ResendVerificationStates extends AuthState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  const ResendVerificationStates(
      {this.isLoading = false, this.isSuccess = false, this.error});

  ResendVerificationStates copyWith(
      {bool? isLoading, bool? isSuccess, String? error}) {
    return ResendVerificationStates(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}

//-------->> request-password-reset
class RequestPassResetInit extends AuthState {}

class RequestPassResetIsLoading extends AuthState {}

class RequestPassResetSuccess extends AuthState {}

class RequestPassResetFailed extends AuthState {
  final String message;
  RequestPassResetFailed({required this.message});
}

//---------> > reset-password
class ResetPassInit extends AuthState {}

class ResetPassIsLoading extends AuthState {}

class ResetPassSuccess extends AuthState {}

class ResetPassFailed extends AuthState {
  final String message;
  ResetPassFailed({required this.message});
}
