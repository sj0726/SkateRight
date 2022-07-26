import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:skateright_flutter/state_control/location_provider.dart';
import 'package:skateright_flutter/state_control/spot_holder.dart';

Future<LocationProvider> initLocationProvider() async {
  // Get the location provider set up
  Location location = Location();
  bool canSeeLocation = await _checkLocationPerms(location);
  LocationData? locationData;
  if (canSeeLocation) {
    locationData = await location.getLocation();
  }
  return LocationProvider(location: location, initialLocation: locationData);
}

Future<bool> _checkLocationPerms(Location location) async {
  var _locationServEnabled = await location.serviceEnabled();
  if (!_locationServEnabled) {
    _locationServEnabled = await location.requestService();

    // If denied -> no point in continuing
    if (!_locationServEnabled) {
      return false;
    }
  }

  var _locationPermEnabled = await location.hasPermission();
  if (_locationPermEnabled == PermissionStatus.denied) {
    _locationPermEnabled = await location.requestPermission();

    if (_locationPermEnabled == PermissionStatus.denied) {
      return false;
    }
  }

  return true;
}