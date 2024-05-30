import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamit/AccountPage/bloc/account_bloc.dart';

// import 'package:share_plus/share_plus.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Preferences"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: BlocConsumer<AccountBloc, AccountState>(
          builder: (context, state) {
            if (state is AccountLoaded || state is NoInternet) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        CircleAvatar(
                          radius: 75,
                          child: Icon(Icons.person),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Khushal Jangid",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is AccountLoading) {
              return const Center(child: CircularProgressIndicator());
              // } else if (state is NoInternet) {
              //   return SizedBox(
              //     width: double.maxFinite,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         const Icon(
              //           Icons.wifi_off,
              //           size: 40,
              //           color: Colors.amber,
              //         ),
              //         Text(
              //           "No Internet",
              //           style: Theme.of(context).textTheme.labelMedium,
              //         ),
              //         const SizedBox(
              //           height: 20,
              //         ),
              //         IconButton.outlined(
              //           onPressed: () {},
              //           icon: const Row(
              //             mainAxisSize: MainAxisSize.min,
              //             children: [
              //               Icon(Icons.refresh),
              //               Text("Refresh"),
              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //   );
            } else {
              //error
              return const Center(
                child: Text('Error Occured'),
              );
            }
          },
          listener: (context, state) {}),
    );
  }
}
