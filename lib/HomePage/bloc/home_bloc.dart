import 'package:bloc/bloc.dart';
import 'package:streamit/HomePage/Data/homedata.dart';
import 'package:meta/meta.dart';
import 'package:streamit/utils.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<HomeLoadEvent>((event, emit) async {
      final c = await checkConnection();
      if (c) {
        HomeScreenData? homeScreenData = await HomeDataBaseQuery().initData();
        if (homeScreenData != null) {
          emit(HomeLoaded(homeScreenData));
        } else {
          emit(Home404());
        }
      } else {
        emit(NoInternet());
      }
    });
    add(HomeLoadEvent());
  }
  reset() async {
    add(HomeLoadEvent());
    // HomeScreenData? homeScreenData = await HomeDataBaseQuery().initData();
    // if (homeScreenData != null) {
    //   emit(HomeLoaded(homeScreenData));
    // }
  }
}
