import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamit/AccountPage/Presentation/themeselector.dart';
import 'package:streamit/AccountPage/bloc/account_bloc.dart';
import 'package:streamit/DatabaseConfig/storagemanager.dart';
import 'package:streamit/constants.dart';

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
                        data.avatar.isNotEmpty
                            ? Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      "$baseUrl/${data.avatar}",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                child: const Icon(Icons.person),
                              ),
                        const SizedBox(
                          height: 30,
                        ),
                        ListTile(
                          leading: const Icon(Icons.person_outline),
                          title: Text(
                            "${data.firstName} ${data.lastName}",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.email_outlined),
                          title: Text(
                            data.email,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.phone_outlined),
                          title: Text(
                            "+91-${data.phone}",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          onTap: () {
                            showThemeSelector(context);
                          },
                          leading: const Icon(Icons.light_mode_outlined),
                          title: const Text("Theme"),
                          subtitle: FutureBuilder(
                              future: StorageManager.readData('themeMode'),
                              builder: (context, s) {
                                if (s.hasData) {
                                  final String mode = s.data;
                                  return Text(
                                    "${mode[0].toUpperCase()}${mode.substring(1)}",
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              }),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.help_outline),
                          title: Text(
                            "Help",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.info_outline),
                          title: Text(
                            "About",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        )
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
