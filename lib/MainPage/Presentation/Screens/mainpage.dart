import 'package:flutter/cupertino.dart';
import 'package:streamit/AccountPage/Presentation/accountpage.dart';
import 'package:streamit/AccountPage/bloc/account_bloc.dart';
import 'package:streamit/HomePage/Presentation/homepage.dart';
import 'package:streamit/HomePage/bloc/home_bloc.dart';
import 'package:streamit/MainPage/cubit/tab_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamit/MyCoursePage/Presentation/coursepage.dart';
import 'package:streamit/MyCoursePage/bloc/course_bloc.dart';
import 'package:streamit/WishlistPage/Presentation/wishlist.dart';
import 'package:streamit/WishlistPage/bloc/wishlist_bloc.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final List items = [
    CupertinoIcons.house,
    Icons.video_collection_outlined,
    CupertinoIcons.heart,
    CupertinoIcons.person_circle
  ];
  final List filleditems = [
    CupertinoIcons.house_fill,
    Icons.video_collection,
    CupertinoIcons.heart_fill,
    CupertinoIcons.person_circle_fill
  ];
  final List title = [
    "Home",
    "Videos",
    "Saved",
    "Account",
  ];
  final List<Widget> screens = [
    const HomePage(),
    const CoursePage(),
    const WishlistPage(),
    const AccountPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => HomeBloc())),
        BlocProvider(create: ((context) => AccountBloc())),
        BlocProvider(create: ((context) => WishlistBloc())),
        BlocProvider(create: ((context) => CourseBloc())),
      ],
      child: BlocBuilder<TabCubit, int>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: screens[state],
              bottomNavigationBar: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      color: Theme.of(context).bottomAppBarTheme.shadowColor!,
                    ),
                  ],
                  color: Theme.of(context).bottomAppBarTheme.color,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: items
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            Feedback.forTap(context);
                            BlocProvider.of<TabCubit>(context)
                                .changetab(items.indexOf(e));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: state == items.indexOf(e)
                                  ? Colors.green.shade100
                                  : null,
                            ),
                            child: Icon(
                              state == items.indexOf(e)
                                  ? filleditems[state]
                                  : items[items.indexOf(e)],
                              size: 30,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
