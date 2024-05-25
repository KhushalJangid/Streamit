part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class Authenticated extends AuthState {}

final class NotAuthenticated extends AuthState {}

final class AuthFailure extends AuthState {}

final class AuthLoading extends AuthState {}

final class LoginState extends AuthState {}
