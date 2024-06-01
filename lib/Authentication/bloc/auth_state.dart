part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthLoading extends AuthState {}

final class Authenticated extends AuthState {}

final class NotAuthenticated extends AuthState {}

final class LoginFailure extends AuthState {
  final String error;
  LoginFailure(this.error);
}

final class SignupState extends AuthState {}

final class SignupFailure extends AuthState {}

final class OnboardingState extends AuthState {
  final List<String> tags;
  OnboardingState(this.tags);
}
