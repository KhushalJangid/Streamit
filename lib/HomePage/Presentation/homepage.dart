import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamit/HomePage/Data/homedata.dart';
import 'package:streamit/HomePage/bloc/home_bloc.dart';
import 'package:streamit/HomePage/cubit/notificationCount.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

// import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        actions: [],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [],
                ),
              );
            } else if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
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
