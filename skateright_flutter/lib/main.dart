import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cloud_functions/cloud_functions.dart';

import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:skateright_flutter/map/fake_spot.dart';
import 'package:skateright_flutter/onboarding/onboarding.dart';
import 'package:skateright_flutter/state_control/location_provider.dart';
import 'package:skateright_flutter/state_control/spot_holder.dart';

import 'package:skateright_flutter/splash_screen.dart';
import 'entities/spot.dart';
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
  late var _locationServEnabled;
  late var _locationPermEnabled;
  late Location location;
  List<Spot>? nearbySpots;

  @override
  void initState() {
    super.initState();
    _buildChild = const SplashScreen();
    location = Location();
    // _controller =
    //     AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  Future<String> _loadMapStyle() {
    Future<String> asString =
        DefaultAssetBundle.of(context).loadString('assets/map/map_style.json');
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

  Future<bool> _checkLocationPerms() async {
    _locationServEnabled = await location.serviceEnabled();
    if (!_locationServEnabled) {
      _locationServEnabled = await location.requestService();

      // If denied -> no point in continuing
      if (!_locationServEnabled) {
        return false;
      }
    }

    _locationPermEnabled = await location.hasPermission();
    if (_locationPermEnabled == PermissionStatus.denied) {
      _locationPermEnabled = await location.requestPermission();

      if (_locationPermEnabled == PermissionStatus.denied) {
        return false;
      }
    }

    return true;
  }

  /// Populate the initial list of spots to be added to SpotProvider
  /// Returns an unused value in order to signal the future to complete
  Future<dynamic> querySpots(LocationData currentLocation) async {
    var firebaseCaller =
        FirebaseFunctions.instance.httpsCallable('getGoogleNearbyOnCall');
    var call = await firebaseCaller.call(<String, dynamic>{
      'latitude': currentLocation.latitude!,
      'longitude': currentLocation.longitude!,
      'radius': 5000,
      'keyword': ''
    });

    List<dynamic> body = call.data['results'];

    var spots = body.map(
      (item) {
        Map<String, dynamic> itemF = Map.from(item);

        return Spot.fromJson(itemF, 'AIzaSyBHbE8gY1lkShRnfptN5wLNJgB06qgFNvg');
      },
    ).toList();
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: skateTheme,
      home: FutureBuilder(
        future: Future.wait(
          [
            _loadMapStyle(),
            _loadCustomMarker(),
            _checkLocationPerms().then(
              (enabled) async {
                if (enabled) {
                  LocationData currentLocation = await location.getLocation();
                  return currentLocation;
                }
              },
            ).then(
              (currentLocation) async {
                nearbySpots = await querySpots(currentLocation!);
                // nearbySpots?.addAll([booth, buBeach]);
                return currentLocation;
              },
            ),
          ],
        ),
        builder: (context, AsyncSnapshot snapshot) {
          /* Loading screen / future error handling */
          if (snapshot.hasError) {
            return Center(
                child: Text('An Error Has Occurred ${snapshot.error}'));
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            String mapStyle = snapshot.data[0];
            BitmapDescriptor customMarker = snapshot.data[1];
            LocationData locationData = snapshot.data[2];

            // Allows access to a locationData throughout the app :)
            Widget mainScreen = StreamProvider<LocationData?>(
              create: (context) => LocationProvider(
                      location: location, initialLocation: locationData)
                  .locationData,
              initialData: locationData,
              child: ChangeNotifierProvider(
                create: (context) => SpotHolder(
                    nearbySpots ?? []), // if nearbyspots is null assign []
                child: MainScreen(mapStyle: mapStyle, markerIcon: customMarker),
              ),
            );

            // Widget mainScreen = ChangeNotifierProvider(
            //     create: (context) => LocationProvider(
            //         location: location, initialLocation: locationData),
            //     child:
            //         MainScreen(mapStyle: mapStyle, markerIcon: customMarker));

            // MaterialPageRoute mainScreenPageRoute =
            //     MaterialPageRoute(builder: (context) => mainScreen);

            _buildChild = mainScreen;
            // OnBoardPage(
            // nextRoute: mainScreenPageRoute,
            // );
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
