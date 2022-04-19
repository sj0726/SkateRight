import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:location/location.dart';

import './spot.dart';
import './fake_spot.dart';
import './hero_dialog_route.dart';
import 'spot_page/spot_popup_card.dart';
import 'search_bar.dart';

void main() {
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
  final GlobalKey<_MapScreenState> _mapKey = GlobalKey();

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(42.350138473333864, -71.11174104622769),
    zoom: 15,
  );

  bool _mapCreated = false;
  late GoogleMapController googleMapController;
  Location location = Location();
  late LocationData _currentLocation;
  late bool _locationServEnabled;
  late PermissionStatus _locationPermEnabled;

  late BitmapDescriptor customMarker;
  late String _mapStyle;
  Set<Marker> _markers = {};

  /*  ----- Init state methods -----   */

  /// Called from [initState]
  void loadCustomMarker() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 20.0), 'assets/map/map_pin.png');
  }

  @override
  void initState() {
    super.initState();
    loadCustomMarker();
    DefaultAssetBundle.of(context).loadString('assets/map/map_style.json').then(
      (asString) {
        _mapStyle = asString;
      },
    ).catchError(
      (error) {
        log(error.toString());
      },
    );
  }

  /// I think this is garbage collection on app closure/changing nav route stack
  @override
  void dispose() {
    super.dispose();
    googleMapController.dispose();
  }

  /*  ----- Methods Called on Map Build -----  */

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

  /// Called from [_myLocationButton]
  /// Moves camera to users current location
  void _goToCurrentLocation() async {
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target:
              LatLng(_currentLocation.latitude!, _currentLocation.longitude!),
          zoom: 16,
        ),
      ),
    );
  }

  /// Called from [build]
  Widget _myLocationButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15, right: 15),
      child: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: _goToCurrentLocation,
          child: const Icon(
              Icons.my_location), //alt: my_location, memory, control_camera
          // Note: pin_drop seems good for placing spot button
        ),
      ),
    );
  }

  /// Called from [_onMapCreated]
  /// TODO: Delete after database connection set up
  void setDummyMarkers() {
    _markers.clear();
    addSpotMarker(fakeSpot);
    addSpotMarker(fakeSpot1);

    _markers.add(
      Marker(
        markerId: MarkerId("Agganis Arena"),
        position: LatLng(42.35260646322381, -71.11782537730139),
        icon: customMarker,
        infoWindow: InfoWindow(
          title: "Agganis Arena INFO",
        ),
      ),
    );
  }

  void _onMapCreated(controller) async {
    setState(
      // Set map style
      () {
        googleMapController = controller;
        if (_mapStyle != null) {
          googleMapController.setMapStyle(_mapStyle).catchError(
                (error) => log("Error setting map style:" + error.toString()),
              );
        } else {
          log("GoogleMapView:_onMapCreated: Map style could not be loaded.");
        }

        setDummyMarkers();
      },
    );

    // Ensure/Request location permissions
    _checkLocationPerms().then((enabled) async {
      if (enabled) {
        _currentLocation = await location.getLocation();

        location.onLocationChanged
            .listen((newPos) => _currentLocation = newPos);
      }
    });

    _mapCreated = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          GoogleMap(
            mapToolbarEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _onMapCreated(controller),
            markers: _markers,
            buildingsEnabled: false,
          ),
          SearchBar(
            placeSpotMarker: addSpotMarker,
            goToSpot: goToSpot,
          ),
          _myLocationButton(),
        ],
      ),
    );
  }

  /*  ----- Methods Utilized Externally -----  */

  _onMarkerTap(Spot spot) {
    Navigator.of(context).push(
      HeroDialogRoute(builder: (context) => SpotPopupCard(spot: spot)),
    );
  }

  /// Called from [SearchBar]
  /// Centers camera on given spot
  void goToSpot(Spot spot) {
    // Add spot marker to map if not there already
    addSpotMarker(spot);

    LatLng newLatLng = LatLng(spot.latitude, spot.longitude);
    googleMapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: newLatLng, zoom: 15.5),
      ),
    );
    googleMapController.showMarkerInfoWindow(MarkerId(spot.id));
  }

  /// Called from [SearchBar]
  /// In future should be called from a method loadArea(LatLng,  radius)
  ///
  /// Places a spot marker on map if not on map already
  addSpotMarker(Spot spot) {
    Marker newMarker = Marker(
      markerId: MarkerId(spot.id),
      position: LatLng(spot.latitude, spot.longitude),
      icon: customMarker,
      onTap: () => _onMarkerTap(spot),
    );

    if (!_markers.contains(newMarker)) {
      setState(() => _markers.add(newMarker));
    }
  }
}
