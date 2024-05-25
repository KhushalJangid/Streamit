import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamit/Authentication/data/data_provider/authentication.dart';
import 'package:streamit/DatabaseConfig/storagemanager.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    _initialize();

    // on<GetStartedClicked>((event, emit) => emit(LoginState()));

    on<LoginButtonPressed>((event, emit) async {
      emit(AuthLoading());
      // User? user = await GoogleSignInProvider().signInWithGoogle();
      bool user = await login(event.email, event.password);
      if (user == false) {
        emit(AuthFailure());
      } else {
        emit(Authenticated());
      }
    });

    // on<SetupInitiate>((event, emit) => emit(CurrencyState()));
    on<LogoutButtonPressed>((event, emit) async {
      SharedPreferences.getInstance().then((value) => value.clear());
      emit(NotAuthenticated());
    });
    on<SetupComplete>((event, emit) => emit(Authenticated()));
    // close();
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
  }

  void _initialize() async {
    final loggedin = await StorageManager.readData("token");

    if (loggedin) {
      bool? setupComplete = await StorageManager.readData('Setup');
      if (setupComplete != null && setupComplete == true) {
        emit(Authenticated());
      } else {
        emit(LoginState());
      }
    } else {
      emit(NotAuthenticated());
    }
  }
}
