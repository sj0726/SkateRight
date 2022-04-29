import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skateright_flutter/splash_screen.dart';
import 'main_screen.dart';
import 'styles/skate_theme.dart';
import 'package:firebase_core/firebase_core.dart';

// void main() => runApp(MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Delete once google Places calls are made from firebase
  ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  Widget? _buildChild;
  // late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _buildChild = SplashScreen();
    // _controller =
    //     AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: skateTheme,
      home: FutureBuilder(
        future: Future<String>.delayed(
            const Duration(seconds: 3), () => 'Data Loaded'),
        builder: (context, AsyncSnapshot snapshot) {
          /* Loading screen / future error handling */
          if (snapshot.hasError) {
            return Center(
                child: Text('An Error Has Occurred ${snapshot.error}'));
          } else if (snapshot.connectionState == ConnectionState.done) {
            _buildChild = MainScreen();
          }

          return AnimatedSwitcher(
            transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
            },
            duration: const Duration(milliseconds: 2000),
            child: _buildChild,
          );
        },
      ),
    );
  }
}
