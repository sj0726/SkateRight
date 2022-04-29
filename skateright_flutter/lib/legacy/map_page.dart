import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:firebase_core/firebase_core.dart';

import '../entities/spot.dart';
import '../map/fake_spot.dart';
import '../styles/hero_dialog_route.dart';
import '/spot_page/spot_popup_card.dart';
import 'search_bar.dart';

late GoogleMapController globalMapController;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MapPage());
}

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Maps Demo',
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context),
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(42.350138473333864, -71.11174104622769),
    zoom: 15,
  );

  bool _mapCreated = false;
  late GoogleMapController googleMapController;
  Location location = Location();
  late LocationData _locationData;
  late bool _locationServEnabled;
  late PermissionStatus _locationPermEnabled;

  late BitmapDescriptor customMarker;
  late String _mapStyle;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    setCustomMarker();
    DefaultAssetBundle.of(context)
        .loadString('assets/map/map_style.json')
        .then((asString) {
      _mapStyle = asString;
    }).catchError((error) {
      log(error.toString());
    });
  }

  void setCustomMarker() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 5.0), 'assets/map/map_pin.png');
  }

  _onMarkerTap(Spot spot) {
    Navigator.of(context).push(
      HeroDialogRoute(builder: (context) => SpotPopupCard(spot: spot)),
    );
  }

  void _setMapStyle() {
    getJsonFile('assets/map/map_style.json').then((value) => _mapStyle = value);
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void _onMapCreated(controller) async {
    globalMapController = controller;
    // Set map controller
    setState(() {
      googleMapController = controller;
      if (_mapStyle != null) {
        googleMapController.setMapStyle(_mapStyle).then((value) {
          log("Map Style set");
        }).catchError(
            (error) => log("Error setting map style:" + error.toString()));
      } else {
        log("GoogleMapView:_onMapCreated: Map style could not be loaded.");
      }

      setMarkers();
      // _googleMapController.setMapStyle(_mapStyleString);
    });

    _locationServEnabled = await location.serviceEnabled();
    if (!_locationServEnabled) {
      _locationServEnabled = await location.requestService();
    }

    _locationPermEnabled = await location.hasPermission();
    if (_locationPermEnabled == PermissionStatus.denied) {
      _locationPermEnabled = await location.requestPermission();
    }

    _locationData = await location.getLocation();
    print(_locationData);

    location.onLocationChanged.listen((newPos) {
      _locationData = newPos;
    });

    _mapCreated = true;
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  setMarkers() {
    _markers.clear();
    _markers.add(
      Marker(
        markerId: MarkerId("GSU"),
        position: LatLng(42.35111488978059, -71.10889075787007),
        // icon: BitmapDescriptor.defaultMarkerWithHue(50),
        icon: customMarker,
        infoWindow: InfoWindow(
          title: "George Sherman Union",
          snippet: "more info...",
          onTap: () => _onMarkerTap(fakeSpot1),
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId("808"),
        position: LatLng(42.350669405851505, -71.11207366936073),
        // icon: BitmapDescriptor.defaultMarkerWithHue(50),
        icon: customMarker,
        onTap: () => _onMarkerTap(fakeSpot),
      ),
    );

    _markers.add(
      // body: pageList[_pageIndex],
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: _pageIndex,
      //   selectedItemColor: Colors.purple[600],
      //   onTap: _onNavigationTap,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Spots'),
      //     BottomNavigationBarItem(icon: Icon(Icons.cookie), label: 'Clicker'),
      //   ],
      // ),
      Marker(
        markerId: MarkerId("Agganis Arena"),
        position: LatLng(42.35260646322381, -71.11782537730139),
        // icon: BitmapDescriptor.defaultMarkerWithHue(50),
        icon: customMarker,
        // onTap: _onMarkerTap(fakeSpot), /// Being called on build for some reason
        infoWindow: InfoWindow(
          title: "Agganis Arena INFO",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // floatingActionButton: !searching
      //     ? FloatingActionButton(
      //         child: const Icon(Icons.search),
      //         onPressed: () => setState(() => searching = !searching)
      //         )
      //     : null,
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _onMapCreated(controller),
            markers: _markers,
          ),
          SearchBar(),
        ],
      ),
    );
  }

  GoogleMapController getMapController() {
    return googleMapController;
  }
}

/**
 * EVERYTHING BELOW THIS POINT IS DEPRECATED
 * 
 * Spot info cards now handled in spot_popup.dart
 */

/// Formats title of spot so it displays in bigger font
/// Used in [_SpotPopupCard]
class _SpotTitle extends StatelessWidget {
  const _SpotTitle({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18));
  }
}

/// Formats comments/reviews
/// Called by [_SpotPopupCard]
class _SpotComments extends StatelessWidget {
  const _SpotComments({Key? key, required this.comments}) : super(key: key);

  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (final cmnt in comments) _SpotCommentTile(comment: cmnt),
    ]);
  }
}

/// Formats individual comments as they appear in the list of comments
/// Called by [_SpotComments]
class _SpotCommentTile extends StatelessWidget {
  const _SpotCommentTile({Key? key, required this.comment}) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    Icon trailing = const Icon(Icons.favorite, color: Colors.transparent);
    if (comment.isReview) {
      trailing = const Icon(Icons.favorite, color: Colors.red);
    }

    return ListTile(
      leading: const Icon(Icons.person, color: Colors.blue),
      trailing: trailing,
      title: Text(comment.user),
      subtitle: Text(comment.description),
      // tileColor: Colors.grey[300],
      minVerticalPadding: 13,
    );
  }
}

class _SpotPictures extends StatelessWidget {
  const _SpotPictures({Key? key, required this.pictures}) : super(key: key);

  final List<String> pictures;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 240,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: ListView(
              // padding: const EdgeInsets.symmetric(horizontal: 40),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                for (final pic in pictures) _SpotPictureTile(picture: pic),
              ],
            )));
  }
}

class _SpotPictureTile extends StatelessWidget {
  const _SpotPictureTile({Key? key, required this.picture}) : super(key: key);

  final String picture;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage(picture),
      fit: BoxFit.fill,
    );
  }
}

class _SpotPopupCard extends StatelessWidget {
  const _SpotPopupCard({Key? key, required this.spot}) : super(key: key);
  final Spot spot;

  @override
  Widget build(BuildContext context) {
    /// TODO: Find a way to add a RectTween to hero to get an animation to play
    /// Possible solution - wrap [_SpotPopupCard] in a Gesture widget
    ///   set onTap: this, child: rectTween
    return Hero(
      tag: spot.id,
      child: Material(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
          color: Colors.grey[100],
          child: Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _SpotTitle(title: spot.title),
                    const SizedBox(
                      height: 12,
                    ),
                    if (spot.pictures != null) ...[
                      const Divider(),
                      _SpotPictures(pictures: spot.pictures)
                    ],
                    const SizedBox(height: 25),
                    const _SpotTitle(title: 'Comments'),
                    if (spot.comments != null) ...[
                      const Divider(),
                      _SpotComments(comments: spot.comments),
                    ],
                  ],
                ),
              ))),
    );
  }
}
