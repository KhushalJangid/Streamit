import 'package:streamit/Authentication/bloc/auth_bloc.dart';
import 'package:streamit/DatabaseConfig/storagemanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetupAccountPage extends StatelessWidget {
  const SetupAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.1, vertical: h * 0.08),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
