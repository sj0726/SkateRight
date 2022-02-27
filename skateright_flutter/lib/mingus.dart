import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Maps Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
    zoom: 11.5,
  );

  late GoogleMapController _googleMapController;
  Set<Marker> _markers = {};

  getData() async {
    /**
     TODO: 
     * GET DATA FROM DATABASE
     * Decode JSON to fit format
     * 
     *  */

    _markers.clear();

  }

  void _onMapCreated(controller) async {
    // Set map controller
    _googleMapController = controller;

    // atm does nothing but clear the set of markers
    await getData();

    // TODO: turn into a loop that reads from JSON
    // see - https://stackoverflow.com/questions/67153885/how-to-add-marker-in-the-google-map-using-json-api-in-flutter
    setState(() {
      _markers.add(const Marker(
        markerId: MarkerId("GSU"),
        position: LatLng(42.35111488978059, -71.10889075787007),
        infoWindow: InfoWindow(
          title: "George Sherman Union INFO",
        ),
      ));

      _markers.add(const Marker(
        markerId: MarkerId("808"),
        position: LatLng(42.350669405851505, -71.11207366936073),
        infoWindow: InfoWindow(
          title: "808 Comm Ave INFO",
        ),
      ));

      _markers.add(const Marker(
        markerId: MarkerId("Agganis Arena"),
        position: LatLng(42.35260646322381, -71.11782537730139),
        infoWindow: InfoWindow(
          title: "Agganis Arena INFO",
        ),
      ));
    });
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _onMapCreated(controller),
        markers: _markers,

        // Lets get rid of some places of interest
        
      ),

      //this centers the map to 808 but with a bit of a zoom
      // can be reused for a search button if needed idk
      /* 
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(_initialCameraPosition),
      ),
      child: const Icon(Icons.center_focus_strong),
       ),
       */
    );
  }
}
