part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent {}

final class WishlistLoadEvent extends WishlistEvent {}
