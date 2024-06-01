import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:streamit/HomePage/Presentation/homepage.dart';
import 'package:streamit/MyCoursePage/bloc/course_bloc.dart';

// import 'package:share_plus/share_plus.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("My Courses"),
      ),
      body: BlocConsumer<CourseBloc, CourseState>(
          builder: (context, state) {
            if (state is CourseLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    for (var course in state.data) CourseCard(media: course)
                  ],
                ),
              );
            } else if (state is CourseLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NoInternet) {
              return SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.wifi_off,
                      size: 40,
                      color: Colors.amber,
                    ),
                    Text(
                      "No Internet",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    IconButton.outlined(
                      onPressed: () {},
                      icon: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.refresh),
                          Text("Refresh"),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else if (state is Course404) {
              return Center(
                child: Lottie.asset(
                  'assets/animations/404.json',
                  repeat: false,
                ),
              );
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
