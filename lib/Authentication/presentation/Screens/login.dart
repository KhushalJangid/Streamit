import 'package:streamit/Authentication/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  var icon = const Icon(Icons.remove_red_eye_outlined);

  final _formkey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText == true) {
        icon = const Icon(Icons.remove_red_eye_outlined);
      } else {
        icon = const Icon(Icons.remove_red_eye);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authbloc = BlocProvider.of<AuthBloc>(context);
    // double h = MediaQuery.of(context).size.height;
    // double w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Login Failed')));
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(
                      height: 100.0,
                    ),
                    Text(
                      "Email",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: email,
                      style: Theme.of(context).inputDecorationTheme.labelStyle,
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Password",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: password,
                      style: Theme.of(context).inputDecorationTheme.labelStyle,
                      decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: IconButton(
                            icon: icon,
                            onPressed: () {
                              _toggle();
                            },
                          )),
                      obscureText: _obscureText,
                      obscuringCharacter: "*",
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text("Forgot password ?")),
                    const SizedBox(height: 40.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          authbloc.add(
                            LoginButtonPressed(email.text, password.text),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60.0),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          authbloc.add(NavigateSignup());
                        },
                        child: const Text(
                          "Don't have an account? Signup",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ));
  }
}
