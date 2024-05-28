import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:streamit/Authentication/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
        if (state is SignupFailure) {
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
                      "Signup",
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
                    const SizedBox(height: 40.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          authbloc.add(
                            LoginButtonPressed(email.text, password.text),
                          );
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60.0),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          authbloc.add(NavigateLogin());
                        },
                        child: const Text(
                          "Already have an account? Login instead",
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
