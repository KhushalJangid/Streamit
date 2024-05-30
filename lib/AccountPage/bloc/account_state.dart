part of 'account_bloc.dart';

@immutable
sealed class AccountState {}

final class AccountInitial extends AccountState {}

final class AccountLoading extends AccountState {}

final class AccountLoaded extends AccountState {}

final class Account404 extends AccountState {}

final class NoInternet extends AccountState {}
