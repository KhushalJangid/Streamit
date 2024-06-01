import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:streamit/DatabaseConfig/course_model.dart';
import 'package:streamit/WishlistPage/Data/wishlistdata.dart';
import 'package:streamit/utils.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading()) {
    on<WishlistLoadEvent>((event, emit) async {
      final c = await checkConnection();
      if (c) {
        final data = await loadData();
        if (data.isNotEmpty) {
          emit(WishlistLoaded(data));
        } else {
          emit(Wishlist404());
        }
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
