part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoaded extends AuthEvent {
  final bool loggedin;
  AuthLoaded(this.loggedin);
}

final class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;
  LoginButtonPressed(this.email, this.password);
}

final class SignupButtonPressed extends AuthEvent {
  final String email;
  final String password;
  SignupButtonPressed(this.email, this.password);
}

final class OnboardingButtonPressed extends AuthEvent {
  final String selectedTag;
  OnboardingButtonPressed(this.selectedTag);
}

final class LogoutButtonPressed extends AuthEvent {}

final class NavigateLogin extends AuthEvent {}

final class NavigateSignup extends AuthEvent {}
