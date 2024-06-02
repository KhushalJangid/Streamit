import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            if (state is AccountLoaded) {
              final data = state.data;
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
                            "${data.firstName} ${data.lastName}",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            data.email,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 30,
                        ),
                        CupertinoListTile(title: Text("Title")),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "+91-${data.phone}",
                            style: Theme.of(context).textTheme.titleLarge,
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
            } else {
              return const Center(
                child: Text('Error Occured'),
              );
            }
          },
          listener: (context, state) {}),
    );
  }
}
