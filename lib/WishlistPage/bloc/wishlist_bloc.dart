import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:streamit/utils.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading()) {
    on<WishlistLoadEvent>((event, emit) async {
      final c = await checkConnection();
      print(c);
      if (c) {
        // WishlistScreenData? WishlistScreenData = await WishlistDataBaseQuery().initData();
        // if (WishlistScreenData != null) {
        //   emit(WishlistLoaded(WishlistScreenData));
        // } else {
        emit(Wishlist404());
        // }
      } else {
        emit(NoInternet());
      }
    });
    add(WishlistLoadEvent());
  }
  reset() async {
    add(WishlistLoadEvent());
    // WishlistScreenData? WishlistScreenData = await WishlistDataBaseQuery().initData();
    // if (WishlistScreenData != null) {
    //   emit(WishlistLoaded(WishlistScreenData));
    // }
  }
}
