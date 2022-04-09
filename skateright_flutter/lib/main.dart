import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'styles/skate_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.light(),
      theme: skateTheme,
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
