import 'package:streamit/Authentication/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int selected = -1;
  @override
  Widget build(BuildContext context) {
    final authbloc = BlocProvider.of<AuthBloc>(context);
    return SafeArea(
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is OnboardingState) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Select an exam",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              centerTitle: false,
              elevation: 10,
            ),
            body: ListView.builder(
              itemCount: state.tags.length,
              itemBuilder: (context, idx) {
                return GestureDetector(
                  onTap: () {
                    selected = idx;
                    setState(() {});
                  },
                  child: Card(
                    color: selected == idx ? Colors.green.shade100 : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                      child: Text(
                        state.tags[idx],
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ),
                );
              },
            ),
            bottomNavigationBar: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: ElevatedButton(
                child: const Text("Continue"),
                onPressed: () {
                  authbloc.add(OnboardingButtonPressed(state.tags[selected]));
                },
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
