import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:streamit/DatabaseConfig/user_model.dart';
part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountLoading()) {
    on<AccountLoadEvent>((event, emit) async {
      try {
        emit(AccountLoaded(await UserMedia.read()));
      } catch (e) {
        print(e);
        emit(Account404());
      }
    });
    add(AccountLoadEvent());
  }
  reset() async {
    add(AccountLoadEvent());
  }
}
