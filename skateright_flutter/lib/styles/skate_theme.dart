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
  accentColor: sLightGreen, // Controls the text cursor color
  secondaryHeaderColor: sYellow,
  cardColor: sCream,
  splashColor: sDarkGreen,
  primaryColorLight: sCream,
  primaryColorDark: sBlack,

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
      fontSize: 20, // Supposed to be 18 but I like this better
      fontWeight: FontWeight.w400,
      color: sCream,
    ),
    subtitle1: TextStyle(
        fontFamily: 'Karla', fontSize: 18, color: sCream), // Should be 16
    bodyText1: TextStyle(
        fontFamily: 'Karla', fontSize: 16, color: sCream), // Should be 15
    bodyText2: TextStyle(
        fontFamily: 'Karla', fontSize: 14, color: sCream), // Should be 12
  ),
  listTileTheme: ListTileThemeData(
    tileColor: sCream,
    iconColor: sBlack,
    textColor: sBlack,
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateColor.resolveWith((states) => sLightGreen),
    checkColor: MaterialStateColor.resolveWith((states) => sBlack),
    overlayColor: MaterialStateColor.resolveWith((states) => sLightGreen),
  ),

  // Used in main_screen.dart
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showUnselectedLabels: false,
    showSelectedLabels: false,

    // TODO - Figure out NavBar color scheme
    backgroundColor: Colors.grey[850],
    selectedItemColor: sLightGreen,
    unselectedItemColor: Colors.grey,

    /// Doesn't work...
    unselectedLabelStyle:
        const TextStyle(fontFamily: 'Karla', fontSize: 14, color: Colors.pink),
    selectedLabelStyle:
        const TextStyle(fontFamily: 'Karla', fontSize: 14, color: Colors.blue),

    type: BottomNavigationBarType.fixed,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: sDarkGreen,
    // titleTextStyle: TextStyle(fontFamily: 'Karla', fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)
  ),

  /* Taken from Figma */
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.resolveWith(
        (states) => const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 4,
        ),
      ),
      fixedSize:
          MaterialStateProperty.resolveWith((states) => const Size(151, 38)),
      backgroundColor: MaterialStateColor.resolveWith((states) => sDarkGreen),
      textStyle: MaterialStateTextStyle.resolveWith(
        (states) => const TextStyle(
            color: sCream,
            fontFamily: 'Roboto Mono',
            fontSize: 17,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0588235294117647
            // textStyle: MaterialStateProperty.resolveWith((states) => skateTheme.textTheme.headline1!.copyWith(color: Colors.white))
            ),
      ),
    ),
  ),
);
