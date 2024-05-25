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
  var icon = Icon(Icons.remove_red_eye_outlined);

  final _formkey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  // final minSize = Size(48, 48);
  // final maxSize = Size(75, 75);

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText == true) {
        icon = Icon(Icons.remove_red_eye_outlined);
      } else {
        icon = Icon(Icons.remove_red_eye);
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
        // if (state is  AuthFailure) {
        //   ScaffoldMessenger.of(context)
        //       .showSnackBar(const SnackBar(content: Text('Login Failed')));
        // }
        // if (state is SetupState) {
        //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        //     return const SetupAccountPage();
        //   }));
        // }
        // if (state is Authenticated) {
        //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        //     return  MainPage();
        //   }));
        // }
      },
      builder: (context, state) {
        if (state is NotAuthenticated) {
          return SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const SizedBox(
                      height: 100.0,
                    ),
                    Text("Email", style: Theme.of(context).textTheme.headline2),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: email,
                      style: Theme.of(context).inputDecorationTheme.labelStyle,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text("Password",
                        style: Theme.of(context).textTheme.headline2),
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
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: const Text("Forgot password ?")),
                      ],
                    ),
                    const SizedBox(height: 80.0),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Don't have an account? Signup",
                          style: TextStyle(fontSize: 14),
                        )),
                    ElevatedButton(
                      onPressed: () {
                        authbloc.add(
                          LoginButtonPressed(email.text, password.text),
                        );
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10)),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}
