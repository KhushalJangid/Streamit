import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:streamit/DatabaseConfig/course_model.dart';
import 'package:streamit/MyCoursePage/bloc/course_bloc.dart'
    show CourseBloc, CourseLoaded, CourseState;
import 'package:streamit/Player/Presentation/minplayer.dart';
import 'package:streamit/Player/Presentation/playerscreen.dart';
import 'package:streamit/Player/bloc/player_bloc.dart'
    show PlayerBloc, StartPlayer;
import 'package:streamit/customPlayer/provider/orientation.dart';
import 'package:streamit/customPlayer/provider/playerprovider.dart';
import 'package:streamit/ViewCoursePage/Data/viewcoursedata.dart';
import 'package:streamit/ViewCoursePage/bloc/viewcourse_bloc.dart';
import 'package:streamit/WishlistPage/bloc/wishlist_bloc.dart'
    show WishlistBloc, WishlistLoaded, WishlistState;
import 'package:streamit/constants.dart';
import 'package:streamit/utils.dart';
import 'package:provider/provider.dart';

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Colors.transparent,
              ),
            ),
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocConsumer<ViewCourseBloc, ViewCourseState>(
            builder: (context, state) {
              if (state is ViewCourseLoaded) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  "$baseUrl/${state.data.course.thumbnail}",
                              width: double.maxFinite,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              state.data.course.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(state.data.course.type),
                            Text(
                              state.data.course.description,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              "₹${state.data.course.price}.00",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Last Updated : ${DateFormat.yMMMMd().format(state.data.course.uploaded)}",
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: BlocBuilder<WishlistBloc,
                                              WishlistState>(
                                          builder: (context, wstate) {
                                        if (wstate is WishlistLoaded) {
                                          if (wstate.data.indexWhere(
                                                (e) =>
                                                    e.uniqueName ==
                                                    state
                                                        .data.course.uniqueName,
                                              ) !=
                                              -1) {
                                            return OutlinedButton(
                                              onPressed: () {
                                                removeFromWishlist(
                                                  state.data.course,
                                                );
                                                BlocProvider.of<WishlistBloc>(
                                                        context)
                                                    .reset();
                                              },
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Icon(CupertinoIcons
                                                      .heart_fill),
                                                  Text("Saved"),
                                                ],
                                              ),
                                            );
                                          }
                                        }
                                        return OutlinedButton(
                                          onPressed: () {
                                            addToWishlist(state.data.course);
                                            BlocProvider.of<WishlistBloc>(
                                                    context)
                                                .reset();
                                          },
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(CupertinoIcons.heart),
                                              Text("Save"),
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child:
                                          BlocBuilder<CourseBloc, CourseState>(
                                              builder: (context, wstate) {
                                        if (wstate is CourseLoaded) {
                                          if (wstate.data.indexWhere(
                                                (e) =>
                                                    e.uniqueName ==
                                                    state
                                                        .data.course.uniqueName,
                                              ) !=
                                              -1) {
                                            return ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                ),
                                              ),
                                              onPressed: () {},
                                              child: const Row(
                                                children: [
                                                  Icon(
                                                    Icons.check_circle_outline,
                                                  ),
                                                  Text("Purchased"),
                                                ],
                                              ),
                                            );
                                          }
                                        }
                                        return ElevatedButton(
                                          onPressed: () {
                                            purchase(state.data.course);
                                          },
                                          child: const Row(
                                            children: [
                                              Icon(
                                                Icons
                                                    .shopping_cart_checkout_outlined,
                                              ),
                                              Text("Buy"),
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            for (var video in state.data.videos)
                              VideoCard(
                                media: video,
                                courseId: state.data.course.uniqueName,
                              )
                          ],
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: MiniPlayer(),
                    ),
                  ],
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
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  const VideoCard({super.key, required this.media, required this.courseId});
  final String courseId;
  final VideoMedia media;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        print("Started player for video: ${media.uniqueName}");
        BlocProvider.of<PlayerBloc>(context).add(
          StartPlayer(
            courseId: courseId,
            videoId: media.uniqueName,
            videoTitle: media.title,
          ),
        );
        Navigator.push(
          context,
          // MaterialPageRoute(
          //   builder: (context) => PlayerScreen(
          //     key: UniqueKey(),
          //   ),
          // ),
          createAnimatedRoute(
            ChangeNotifierProvider(
              create: (context) => OrientationProvider(),
              child: ChangeNotifierProvider(
                create: (context) => PlayerProvider(),
                child: const PlayerScreen(),
              ),
            ),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(media.id.toString()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: "$baseUrl${media.thumbnail}",
                    width: width * 0.3,
                    height: (width * 0.3) * 0.5625,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      media.title,
                      softWrap: true,
                      textAlign: TextAlign.left,
                    ),
                    // Card.outlined(
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: 8,
                    //       vertical: 4,
                    //     ),
                    //     child: Text(media.uploaded.toString()),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
