part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}
class AuthSignUpIsLoading extends AuthState {}
class AuthSignUpSuccess extends AuthState {
  final int statusCode;
  final bool success;
  final String data;
  AuthSignUpSuccess({required this.statusCode, required this.success, required this.data});
}

class AuthSignUpFailed extends AuthState {
  final int? statusCode;
  final String message;
  AuthSignUpFailed({ this.statusCode, required this.message});
}
