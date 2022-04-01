import 'package:flutter/material.dart';

const sBlack = Color(0xFF141414);
const sCream = Color(0xFFf0e6d0);
const sRed = Color(0xFFEB001B);
const sLightGreen = Color(0xFF94B321);
const sDarkGreen = Color(0xFF015C00);
const sYellow = Color(0xFFf1c200); 
const sYellow1 = Color.fromARGB(255, 206, 187, 19);

final skateTheme = ThemeData(
  // General values that can be aceessed by all inheritors of Theme (all pages)
  backgroundColor: sBlack,
  accentColor: sLightGreen,
  secondaryHeaderColor: sYellow,

  // Text Themes
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
    bodyText2: TextStyle(fontFamily: 'Karla', fontSize: 12, color: sCream),
  ),

  // Used in main_screen.dart
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    // TODO - Figure out NavBar theme
    backgroundColor: Colors.grey[850],
    selectedItemColor: sLightGreen,
    unselectedItemColor: Colors.grey,

    type: BottomNavigationBarType.fixed,
  ),
);
