import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';

class LocationProvider{
  LocationProvider({this.location, this.initialLocation});

  final Location? location;
  LocationData? initialLocation;

  Location? getLocation() => location;

  Stream<LocationData?> get locationData async* {
    LocationData? temp = initialLocation;
    location?.onLocationChanged
        .listen((newLocationData) => temp = newLocationData);
    yield temp;
  }
  Future<LocationData> getLocationData() async {
    try {
      initialLocation = await location!.getLocation();
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }
    return initialLocation!;
  }

/*
  get locationData => _locationData;
  get location => _location; // No reason for this to be called.

  void create(Location location, LocationData locationData) {
    log('WARNING - LocationProvider.create() should only be called at startup');
    _location = location;
    _locationData = locationData;

    location.onLocationChanged
        .listen((newLocationData) => _locationData = newLocationData);
  }
  */
}


/**
 * Notes from documentation:
 * 
 * notifyListeners()
 *   - Call this method any time the model changes in a way that might change your app’s UI.
 */