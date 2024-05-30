import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:streamit/utils.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountLoading()) {
    on<AccountLoadEvent>((event, emit) async {
      final c = await checkConnection();
      print(c);
      if (c) {
        // AccountScreenData? AccountScreenData = await AccountDataBaseQuery().initData();
        // if (AccountScreenData != null) {
        //   emit(AccountLoaded(AccountScreenData));
        // } else {
        emit(Account404());
        // }
      } else {
        emit(NoInternet());
      }
    });
    add(AccountLoadEvent());
  }
  reset() async {
    add(AccountLoadEvent());
    // AccountScreenData? AccountScreenData = await AccountDataBaseQuery().initData();
    // if (AccountScreenData != null) {
    //   emit(AccountLoaded(AccountScreenData));
    // }
  }
}
