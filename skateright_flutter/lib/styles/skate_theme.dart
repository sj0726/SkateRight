import 'package:flutter/material.dart';

const sBlack = Color(0xFF141414);
const sCream = Color(0xFFf0e6d0);
const sRed = Color(0xFFEB001B);
const sLightGreen = Color(0xFF94B321);
const sDarkGreen = Color(0xFF015C00);
const sYellow = Color.fromARGB(255, 206, 187, 19); // Need actual value

final skateTheme = ThemeData(
  // General
  backgroundColor: sBlack,
  accentColor: sLightGreen,

  // Used in main_screen.dart
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    // TODO
  ),
  secondaryHeaderColor: sYellow,

  // Text Theme
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontFamily: 'RobotoMono',
      fontSize: 23,
      fontWeight: FontWeight.w700,
      color: sCream,
    ),
    headline2: TextStyle(
      fontFamily: 'RobotoMono',
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: sCream,
    ),
    subtitle1: TextStyle(fontFamily: 'Karla', fontSize: 16, color: sCream),
    bodyText1: TextStyle(fontFamily: 'Karla', fontSize: 15, color: sCream),
  ),
);
