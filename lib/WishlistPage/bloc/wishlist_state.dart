part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

final class WishlistLoading extends WishlistState {}

final class WishlistLoaded extends WishlistState {
  final List<CourseMedia> data;
  WishlistLoaded(this.data);
}

final class Wishlist404 extends WishlistState {}

final class NoInternet extends WishlistState {}
