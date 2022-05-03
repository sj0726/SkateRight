import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:skateright_flutter/onboarding/onboarding.dart';

import 'package:skateright_flutter/splash_screen.dart';
import 'main_screen.dart';
import 'styles/skate_theme.dart';

// void main() => runApp(MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Delete once google Places calls are made from firebase
  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  Widget? _buildChild;

  @override
  void initState() {
    super.initState();
    _buildChild = SplashScreen();
    // _controller =
    //     AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  Future<String> _loadMapStyle() {
    Future<String> asString =
        DefaultAssetBundle.of(context).loadString('assets/map/map_style.json');
    // .then(
    //   (asString) {
    //     mapStyle = asString;
    //   },
    // ).catchError(
    //   (error) {
    //     log(error.toString());
    //   },
    // );
    return asString;
  }

  Future<BitmapDescriptor> _loadCustomMarker() async {
    String path = 'assets/map/map_pin.png';
    int width = 70;
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    Uint8List byteMarker =
        (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
            .buffer
            .asUint8List();
    return BitmapDescriptor.fromBytes(byteMarker);
    // return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: skateTheme,
      home: FutureBuilder(
        future: Future.wait([
          _loadMapStyle(),
          _loadCustomMarker(),
          Future.delayed(const Duration(milliseconds: 3000))
        ]),
        builder: (context, AsyncSnapshot snapshot) {
          /* Loading screen / future error handling */
          if (snapshot.hasError) {
            return Center(
                child: Text('An Error Has Occurred ${snapshot.error}'));
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            String mapStyle = snapshot.data[0];
            BitmapDescriptor customMarker = snapshot.data[1];
            var mainScreen =
                MainScreen(mapStyle: mapStyle, markerIcon: customMarker);
            MaterialPageRoute mainScreenPageRoute =
                MaterialPageRoute(builder: (context) => mainScreen);

            _buildChild =
                OnBoardPage(nextRoute: mainScreenPageRoute,); //  TODO: Switch line comments to not deal with unnecessary loading
                // mainScreen;  // See above... uncomment to not deal with loading
          }

          return AnimatedSwitcher(
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            duration: const Duration(milliseconds: 1250),
            child: _buildChild,
          );
        },
      ),
    );
  }
}
