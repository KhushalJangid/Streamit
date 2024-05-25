import 'package:streamit/MainPage/cubit/tab_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final List items = [
    Icons.home_outlined,
    Icons.video_collection_outlined,
    Icons.bookmark_outline,
    Icons.person_outline,
  ];
  final List filleditems = [
    Icons.home,
    Icons.video_collection,
    Icons.bookmark,
    Icons.person,
  ];
  final List<Widget> screens = [
    // const HomePage(),
    // MenuPage(),
    // StatisticPage(),
    // const SettingPage()
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
  ];
  @override
  Widget build(BuildContext context) {
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider(create: ((context) => HomeBloc())),
    //     BlocProvider(
    //       lazy: false,
    //       create: (context) => StatisticBloc(),
    //     ),
    //     BlocProvider(
    //       lazy: false,
    //       create: (context) => MenuBloc(),
    //     ),
    //     BlocProvider(lazy: false, create: ((context) => CurrencyManager()))
    //   ],
    //   child: BlocBuilder<TabCubit, int>(
    //     builder: (context, state) {
    //       return Scaffold(
    //         body: screens[state],
    //         bottomNavigationBar: Padding(
    //           padding: const EdgeInsets.symmetric(vertical: 20),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             children: items
    //                 .map((e) => GestureDetector(
    //                       onTap: () {
    //                         // FlutterTts flutterTts = FlutterTts();
    //                         // flutterTts.pla
    //                         Feedback.forTap(context);
    //                         BlocProvider.of<TabCubit>(context)
    //                             .changetab(items.indexOf(e));
    //                       },
    //                       child: SizedBox(
    //                         height: 25,
    //                         width: 25,
    //                         child: SvgPicture.asset(
    //                           state == items.indexOf(e)
    //                               ? filleditems[state]
    //                               : items[items.indexOf(e)],
    //                           colorFilter: AdaptiveTheme.of(context).mode ==
    //                                   AdaptiveThemeMode.light
    //                               ? null
    //                               : const ColorFilter.mode(
    //                                   Colors.white,
    //                                   BlendMode.srcIn,
    //                                 ),
    //                         ),
    //                       ),
    //                     ))
    //                 .toList(),
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
    return BlocBuilder<TabCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: screens[state],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
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
                      child: SizedBox(
                        height: 25,
                        width: 25,
                        child: Icon(
                          state == items.indexOf(e)
                              ? filleditems[state]
                              : items[items.indexOf(e)],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
