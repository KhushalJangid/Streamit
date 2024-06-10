import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamit/DatabaseConfig/course_model.dart';
import 'package:streamit/ViewCoursePage/Data/viewcoursedata.dart';
import 'package:streamit/WishlistPage/bloc/wishlist_bloc.dart';
import 'package:streamit/constants.dart';
import 'package:streamit/utils.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.media});
  final CourseMedia media;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => viewCourse(context, media.id),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: "$baseUrl${media.thumbnail}",
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(media.title),
                  Text("₹${media.price}.00"),
                  Card.outlined(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Text(media.type),
                    ),
                  )
                ],
              ),
            ),
          ),
          BlocBuilder<WishlistBloc, WishlistState>(builder: (context, wstate) {
            if (wstate is WishlistLoaded) {
              if (wstate.data
                      .indexWhere((e) => e.uniqueName == media.uniqueName) !=
                  -1) {
                return Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      removeFromWishlist(media);
                      BlocProvider.of<WishlistBloc>(context).reset();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      margin: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        CupertinoIcons.heart_fill,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }
            }
            return Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  addToWishlist(media);
                  BlocProvider.of<WishlistBloc>(context).reset();
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    CupertinoIcons.heart,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  const CourseTile({super.key, required this.media});
  final CourseMedia media;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => viewCourse(context, media.id),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: "$baseUrl${media.thumbnail}",
                    width: width * 0.4,
                    height: (width * 0.4) * 0.5625,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      media.title,
                      softWrap: true,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "₹${media.price}.00",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      media.description,
                      overflow: TextOverflow.ellipsis,
                    ),
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
