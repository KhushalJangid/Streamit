import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      bool user = await login(event.email, event.password);
      if (user == false) {
        emit(LoginFailure());
      } else {
        emit(Authenticated());
      }
    });
    on<SignupButtonPressed>((event, emit) async {
      emit(AuthLoading());
      bool user = await signup(event.email, event.password);
      if (user == false) {
        emit(LoginFailure());
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
    on<NavigateOnboarding>((event, emit) {
      emit(OnboardingState());
    });
  }

  void initialize() async {
    final bool loggedin = (await StorageManager.readData("token")) ?? false;
    add(AuthLoaded(loggedin));
  }
}
