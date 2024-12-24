part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class VisibilityPassword extends AuthEvent {
  final bool newValue;

  const VisibilityPassword(this.newValue);

  @override
  List<Object> get props => [newValue];
}

class VisibilityRegisterPassword extends AuthEvent {
  final bool newValue;

  const VisibilityRegisterPassword(this.newValue);

  @override
  List<Object> get props => [newValue];
}

class VisibilityConfirmPassword extends AuthEvent {
  final bool newValue;

  const VisibilityConfirmPassword(this.newValue);

  @override
  List<Object> get props => [newValue];
}

class UserLogin extends AuthEvent {
  final String email;
  final String password;

  const UserLogin({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

class UserRegister extends AuthEvent {
  final RegisterRequestModel body;

  const UserRegister({
    required this.body,
  });

  @override
  List<Object> get props => [body];
}

class GetUserLogin extends AuthEvent {}

class UserLogout extends AuthEvent {}

class UserIsLogin extends AuthEvent {}

class SaveUserLogin extends AuthEvent {}

class DeleteUserLogin extends AuthEvent {}

class AuthSetInitial extends AuthEvent {}

class LoginSetInitial extends AuthEvent {}

class RegisterSetInitial extends AuthEvent {}

class LogoutSetInitial extends AuthEvent {}
