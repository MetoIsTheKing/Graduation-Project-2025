import 'package:graduation_project_2025/features/home/profile/presentation/data/profile_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}

class UserSuccess extends UserState {
  final String message;
  UserSuccess(this.message);
}

class UserProfileLoaded extends UserState {
  final UserProfileModel profile;
  UserProfileLoaded(this.profile);
}
