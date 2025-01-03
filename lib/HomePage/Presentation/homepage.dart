import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamit/HomePage/bloc/home_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:streamit/components.dart';
import 'package:streamit/constants.dart';

// import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);
    return BlocConsumer<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  StatefulBuilder(builder: (context, setState) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      width: double.maxFinite,
                      // padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            color: Theme.of(context)
                                .bottomAppBarTheme
                                .shadowColor!,
                          ),
                        ],
                        // color: Theme.of(context).bottomAppBarTheme.color,
                      ),
                      child: Row(
                        children: [
                          TextFormField(
                            controller: searchController,
                            onChanged: (v) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              hintText: "Search",
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: searchController.text.isNotEmpty
                                    ? const Icon(Icons.clear)
                                    : const Icon(Icons.search),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications_outlined,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(
                        milliseconds: 3000,
                      ),
                      viewportFraction: 0.95,
                      enlargeCenterPage: true,
                    ),
                    items: [
                      for (var banner in state.data.banners)
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: "$baseUrl${banner.thumbnail}",
                              width: double.maxFinite,
                              height: double.maxFinite,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                    ],
                  ),
                  for (var course in state.data.courses)
                    CourseCard(media: course)
                ],
              ),
            );
          } else if (state is HomeLoading) {
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
                    onPressed: () {
                      bloc.add(HomeLoadEvent());
                    },
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
          } else {
            return const Center(
              child: Text('Error Occured'),
            );
          }
        },
        listener: (context, state) {});
  }
}
