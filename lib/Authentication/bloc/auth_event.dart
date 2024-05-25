part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;
  LoginButtonPressed(this.email, this.password);
}

final class SignupInitiate extends AuthEvent {}

final class SignupButtonPressed extends AuthEvent {
  final String email;
  final String password;
  SignupButtonPressed(this.email, this.password);
}

final class LogoutButtonPressed extends AuthEvent {}

final class SetupComplete extends AuthEvent {}

final class SetupInitiate extends AuthEvent {}