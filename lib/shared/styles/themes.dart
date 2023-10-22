import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_app/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: const Color(0xffED3336), secondary: Colors.grey.shade300),
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    bodyLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: Colors.black),
    bodyMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black),
    bodySmall: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 14,
        fontWeight: FontWeight.w200,
        color: Colors.black),
    titleLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 25,
        fontWeight: FontWeight.w900,
        color: Colors.black),
    titleMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black),
    titleSmall: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: Colors.black),
    labelSmall: TextStyle(
        fontFamily: 'Cairo', fontSize: 12, height: 1.3.h, color: Colors.black),
    labelMedium: TextStyle(
        fontFamily: 'Cairo', fontSize: 14, height: 1.3.h, color: Colors.black),
  ),
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Color(0xffED3336),
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      elevation: 20,
      type: BottomNavigationBarType.fixed),
);

ThemeData darkTheme = ThemeData(
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: PrimaryColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.grey[900],
      elevation: 20,
      type: BottomNavigationBarType.fixed),
  //primarySwatch: PrimaryColor,
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey[900],
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.grey[900],
    titleTextStyle: const TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  inputDecorationTheme: InputDecorationTheme(
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    iconColor: Color(0xffED3336),
    fillColor: Color(0xffED3336),
  ),
  scaffoldBackgroundColor: Colors.grey[900],
  textTheme: TextTheme(
    bodyLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 20.sp,
        fontWeight: FontWeight.w900,
        color: Colors.white),
    bodyMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white),
    bodySmall: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 14.sp,
        fontWeight: FontWeight.w200,
        color: Colors.white),
    titleLarge: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 25.sp,
        fontWeight: FontWeight.w900,
        color: Colors.white),
    titleMedium: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white),
    titleSmall: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 14.sp,
        fontWeight: FontWeight.w300,
        color: Colors.white),
  ),
);
