import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:streamit/DatabaseConfig/course_model.dart';
import 'package:streamit/ViewCoursePage/bloc/viewcourse_bloc.dart';
import 'package:streamit/constants.dart';

// import 'package:share_plus/share_plus.dart';

class ViewCoursePage extends StatefulWidget {
  const ViewCoursePage({super.key});

  @override
  State<ViewCoursePage> createState() => _ViewCoursePageState();
}

class _ViewCoursePageState extends State<ViewCoursePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        title: const Text("Course"),
      ),
      body: BlocConsumer<ViewCourseBloc, ViewCourseState>(
          builder: (context, state) {
            if (state is ViewCourseLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: "$baseUrl/${state.data.course.thumbnail}",
                      ),
                      Text(state.data.course.title),
                      Text(state.data.course.type),
                      Text(state.data.course.description),
                      Text(state.data.course.price.toString()),
                      Text(state.data.course.uploaded.toString()),
                    ],
                  ),
                ),
              );
            } else if (state is ViewCourseLoading) {
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
            } else if (state is ViewCourse404) {
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

class VideoCard extends StatelessWidget {
  const VideoCard({super.key, required this.media});
  final VideoMedia media;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(media.id.toString()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: "$baseUrl${media.thumbnail}",
                ),
              ),
            ),
            Column(
              children: [
                Text(media.title),
                Card.outlined(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Text(media.uploaded.toString()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
