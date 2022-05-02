import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart';

import '../entities/spot.dart';
import 'fake_spot.dart';
import '../styles/hero_dialog_route.dart';
import '../spot_page/spot_popup_card.dart';
import 'search_bar.dart';
import '../spot_editing/create_spot_page.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, this.mapStyle, required this.customMarker})
      : super(key: key);
  final String? mapStyle;
  final BitmapDescriptor customMarker;

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

  BitmapDescriptor? customMarker;
  String? _mapStyle;
  Set<Marker> _markers = {};

  /*  ----- Init state methods -----   */

  /// Called from [initState]
  /// Initiallizes marker icons
  // loadCustomMarker() async {
  //   String path = 'assets/map/map_pin';
  //   int width = 70;
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
  //       targetWidth: width);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   Uint8List byteMarker =
  //       (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
  //           .buffer
  //           .asUint8List();
  //   customMarker = BitmapDescriptor.fromBytes(byteMarker);
  // }

  /// Old version of loading asset, no option to change size
  void loadCustomMarker1() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(
            devicePixelRatio: MediaQuery.of(context).devicePixelRatio),
        'assets/map/map_pin.png');
  }

  @override
  void initState() {
    super.initState();
    // Ideally we do the following asset loading in the splash loader
    customMarker = widget.customMarker;
    _mapStyle = widget.mapStyle;

    // Overlay setup
    WidgetsBinding.instance
        .addPostFrameCallback((duration) => _createAddSpotOverlay());
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
          heroTag: 'myLocal',
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
    // _markers.clear();

    addSpotMarker(buBeach);
    addSpotMarker(booth);
    // addSpotMarker(fakeSpot);
    // addSpotMarker(fakeSpot1);

    /* Not deleted just to serve as prototype */
    // _markers.add(
    //   Marker(
    //     markerId: MarkerId("Agganis Arena"),
    //     position: LatLng(42.35260646322381, -71.11782537730139),
    //     icon: customMarker,
    //     infoWindow: InfoWindow(
    //       title: "Agganis Arena INFO",
    //     ),
    //   ),
    // );
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
      body: WillPopScope(
        onWillPop: () =>
            (overlayBuilt) // Hides overlay instead of popping the kid
                ? Future.value(_hideAddSpotOverlay())
                : Future.value(true),
        child: Stack(
          children: [
            GoogleMap(
              onLongPress: _showAddSpotOverlay,
              onCameraMove: _onCamMoved,
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
              location: location,
            ),
            _myLocationButton(),
          ],
        ),
      ),
    );
  }

  /* Adding a spot to the map */
  OverlayState? overlay;
  OverlayEntry? topBarOverlay;
  OverlayEntry? pinOverlay;
  bool overlayBuilt = false;
  CameraPosition currentCameraPos = _initialCameraPosition;

  _createAddSpotOverlay() {
    overlay = Overlay.of(context);

    topBarOverlay = OverlayEntry(
      builder: (context) => Align(
        alignment: Alignment.topCenter,
        child: _buildTopBarOverlay(),
      ),
    );

    pinOverlay = OverlayEntry(
      builder: (context) => const Padding(
        // Padding offsets pin so bottom of pin aligns with map placement
        padding: EdgeInsets.only(bottom: 50),
        child: Align(
          alignment: Alignment.center,
          child: Icon(
            // Icons.add_circle,
            Icons.location_pin,
            size: 50,
          ),
        ),
      ),
    );
  }

  Widget _buildTopBarOverlay() {
    Color iconColor = Theme.of(context).primaryColorLight;
    return Material(
      elevation: 4,
      color: Theme.of(context).primaryColorDark,
      child: FractionallySizedBox(
        heightFactor: .15,
        widthFactor: 1,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: (() => _hideAddSpotOverlay()),
                    icon: Icon(
                      Icons.clear_sharp,
                      color: iconColor,
                    )),
                Text(
                  'Done?',
                  style: Theme.of(context).textTheme.headline2,
                ),
                IconButton(
                  onPressed: () {
                    _buildAddSpotPage();
                    _hideAddSpotOverlay();
                    setState(() => _markers.add(tempMarker!));
                  },
                  icon: Icon(
                    Icons.check,
                    color: iconColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showAddSpotOverlay(LatLng pos) {
    googleMapController.animateCamera(CameraUpdate.newLatLng(pos));
    if (!overlayBuilt) {
      overlay!.insert(topBarOverlay!);
      overlay!.insert(pinOverlay!);
    }
    overlayBuilt = true;
  }

  bool _hideAddSpotOverlay() {
    if (overlayBuilt == true) {
      topBarOverlay!.remove();
      pinOverlay!.remove();
    }
    overlayBuilt = false;
    return false; // For use in willPop(), don't worry about this for general use
  }

  Marker? tempMarker;

  _buildAddSpotPage() {
    LatLng cLatLng = currentCameraPos.target;
    tempMarker = Marker(
      markerId: const MarkerId('TEMP'),
      position: currentCameraPos.target,
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CreateSpotPage(
            latitude: cLatLng.latitude,
            longitude: cLatLng.longitude,
          ),
        ),
      ),
      // Delete when user holds down on pin
      draggable: true,
      onDragStart: (_) => (setState(
        () =>
            _markers.removeWhere((element) => element.markerId.value == 'TEMP'),
      )),
    );

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CreateSpotPage(
              latitude: cLatLng.latitude,
              longitude: cLatLng.longitude,
            )));

    // NOTE: Current implementation only allows one custom marker on map at a time
    //   will be fixed once end-to-end support implemented in create_spot_page.dart
    setState(() {
      _markers.removeWhere((element) => element.markerId.value == 'TEMP');
      // _markers.add(tempMarker);
    });
  }

  /// Tracks where the center of the map is
  _onCamMoved(CameraPosition position) {
    if (overlayBuilt) {
      currentCameraPos = position;
    }
  }

  /*  ----- Methods Utilized Externally -----  */

  _onMarkerTap(Spot spot) {
    _hideAddSpotOverlay();
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
        CameraPosition(target: newLatLng, zoom: 16),
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
      icon: customMarker!,
      onTap: () => _onMarkerTap(spot),
    );

    if (!_markers.contains(newMarker)) {
      setState(() => _markers.add(newMarker));
    } else {
      log("marker already exists");
    }
  }
}
