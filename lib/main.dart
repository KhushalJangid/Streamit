import 'package:provider/provider.dart';
import 'package:streamit/Authentication/bloc/auth_bloc.dart';
import 'package:streamit/Authentication/presentation/Screens/login.dart';
import 'package:streamit/Authentication/presentation/Screens/setup.dart';
import 'package:streamit/Authentication/presentation/Screens/signup.dart';
import 'package:streamit/MainPage/Presentation/Screens/mainpage.dart';
import 'package:streamit/MainPage/cubit/tab_cubit.dart';
import 'package:streamit/Player/bloc/player_bloc.dart';
import 'package:streamit/WishlistPage/bloc/wishlist_bloc.dart';
import 'package:streamit/customPlayer/provider/orientation.dart';
import 'package:streamit/theme.dart';
import 'package:streamit/DatabaseConfig/storagemanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(),
        ),
        BlocProvider<TabCubit>(
          create: (BuildContext context) => TabCubit(),
        ),
        BlocProvider(create: ((context) => WishlistBloc())),
        BlocProvider(create: ((context) => PlayerBloc())),
        Provider(create: ((context) => OrientationProvider()))
      ],
      child: AdaptiveTheme(
        light: lightTheme(context),
        dark: darkTheme(context),
        initial: themeNotifier() ?? AdaptiveThemeMode.system,
        builder: (theme, darkTheme) => MaterialApp(
          title: 'StreamIT',
          theme: theme,
          darkTheme: darkTheme,
          home: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            // print(state);
            if (state is Authenticated) {
              return MainPage();
            } else if (state is NotAuthenticated || state is LoginFailure) {
              return const LoginPage();
            } else if (state is SignupState || state is SignupFailure) {
              return const SignupPage();
            } else if (state is OnboardingState) {
              return const OnboardingPage();
            } else {
              return const SplashPage(); //then authbloc can handle
            }
          }),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

themeNotifier() {
  StorageManager.readData('themeMode').then((value) {
    switch (value) {
      case "light":
        return AdaptiveThemeMode.light;
      case "dark":
        return AdaptiveThemeMode.dark;
      case "system":
        return AdaptiveThemeMode.system;
      default:
        StorageManager.saveData('themeMode', 'system');
        return AdaptiveThemeMode.system;
    }
  });
}
