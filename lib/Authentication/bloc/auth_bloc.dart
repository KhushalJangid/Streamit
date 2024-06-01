import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:streamit/Authentication/data/data_provider/authentication.dart';
import 'package:streamit/DatabaseConfig/storagemanager.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthLoading()) {
    initialize();
    on<AuthLoaded>((event, emit) {
      if (event.loggedin) {
        emit(Authenticated());
      } else {
        emit(NotAuthenticated());
      }
    });
    on<LoginButtonPressed>((event, emit) async {
      emit(AuthLoading());
      try {
        bool user = await UserApi().login(event.email, event.password);
        if (user == true) {
          emit(OnboardingState(const [
            "GATE",
            "IIT-JAM",
            "IIT-JEE",
            "CSIR",
            "CAT",
          ]));
        }
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
    on<SignupButtonPressed>((event, emit) async {
      emit(AuthLoading());
      bool user = await UserApi().signup(event.email, event.password);
      if (user == false) {
        emit(SignupFailure());
      } else {
        emit(Authenticated());
      }
    });

    on<LogoutButtonPressed>((event, emit) async {
      SharedPreferences.getInstance().then((value) => value.clear());
      emit(NotAuthenticated());
    });
    on<OnboardingButtonPressed>((event, emit) async {
      StorageManager.saveData("selectedTag", event.selectedTag);
      emit(Authenticated());
    });
    on<NavigateLogin>((event, emit) {
      emit(NotAuthenticated());
    });
    on<NavigateSignup>((event, emit) {
      emit(SignupState());
    });
  }

  void initialize() async {
    final bool loggedin =
        (await const FlutterSecureStorage().read(key: "token")) != null
            ? true
            : false;
    add(AuthLoaded(loggedin));
  }
}
