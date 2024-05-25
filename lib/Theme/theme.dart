import 'package:flutter/material.dart';

enum ThemeColors { orange, green, cyan, pink, blue, violet, yellow }

extension COLOR on ThemeColors {
  Color get color {
    switch (this) {
      case ThemeColors.orange:
        return const Color(0xffffded4);
      case ThemeColors.green:
        return const Color(0xffe1ecfe);
      case ThemeColors.cyan:
        return const Color(0xffd7c8ff);
      case ThemeColors.pink:
        return const Color(0xffffaefd);
      case ThemeColors.blue:
        return const Color(0xffb8d5f1);
      case ThemeColors.violet:
        return const Color(0xffd7c8ff);
      case ThemeColors.yellow:
        return const Color(0xffffdda3);
    }
  }
}

ThemeData lightTheme(BuildContext context) {
  const primaryColor = Colors.black;
  final deviceWidth = MediaQuery.of(context).size.width;
  return ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
    // fontFamily: 'nexa',
    useMaterial3: true,
    colorScheme: ColorScheme.light(
        primary: primaryColor,
        onPrimary: Colors.white,
        secondary: const Color(0xffefefef),
        onSecondary: Colors.white,
        tertiary: Colors.grey.shade200,
        onTertiary: Colors.black),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.15),
        maximumSize: Size(deviceWidth * 0.6, deviceWidth * 0.12),
        minimumSize: Size(deviceWidth * 0.3, deviceWidth * 0.12),
      ),
    ),
    // iconTheme: const IconThemeData(color:Color(0xff7F3DFF),size: 16),
    iconTheme: const IconThemeData(color: Colors.black),
    primaryIconTheme: const IconThemeData(color: Color(0xff7F3DFF), size: 16),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
      prefixStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      suffixIconColor: primaryColor,
      suffixStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      errorStyle:
          TextStyle(color: Colors.red.shade400, fontWeight: FontWeight.bold),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      constraints: BoxConstraints(
        maxWidth: deviceWidth * 0.8,
      ),
      border: const OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: CircleBorder(), elevation: 5),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: primaryColor,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      labelLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      labelMedium: TextStyle(fontSize: 20),
      labelSmall: TextStyle(
          fontSize: 8,
          color: Colors.black,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400),
    ),
  );
}

ThemeData darkTheme(BuildContext context) {
  const primaryColor = Colors.white;
  final deviceWidth = MediaQuery.of(context).size.width;
  return ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
    // fontFamily: 'nexa',
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
        primary: primaryColor,
        onPrimary: Colors.white,
        secondary: Colors.grey.shade500,
        onSecondary: Colors.black,
        tertiary: Colors.grey.shade200,
        onTertiary: Colors.black),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.black,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.15),
        maximumSize: Size(deviceWidth * 0.6, deviceWidth * 0.12),
        minimumSize: Size(deviceWidth * 0.3, deviceWidth * 0.12),
      ),
    ),
    // iconTheme: const IconThemeData(color:Color(0xff7F3DFF),size: 16),
    iconTheme: const IconThemeData(color: Colors.black),
    primaryIconTheme: const IconThemeData(color: Color(0xff7F3DFF), size: 16),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
      prefixStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      suffixIconColor: primaryColor,
      suffixStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      errorStyle:
          TextStyle(color: Colors.red.shade400, fontWeight: FontWeight.bold),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      constraints: BoxConstraints(
        maxWidth: deviceWidth * 0.8,
      ),
      border: const OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: CircleBorder(), elevation: 5),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: primaryColor,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      labelLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      labelMedium: TextStyle(fontSize: 20),
      labelSmall: TextStyle(fontSize: 16),
    ),
  );
}
