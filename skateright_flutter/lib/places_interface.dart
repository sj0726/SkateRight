import 'dart:developer';

import 'package:location/location.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'spot.dart';

class PlacesInterface {
  PlacesInterface({required this.location});

  final Location location;
  LocationData? currentLocation;
  /// ATTN SANJOON:
  /// future plans will have a variable/sliding searchRadius
  ///   - define backend calls as dynamic in searchtem & radius (with cap)
  final int searchRadius = 5000; 
  final String apiKey = "";
  final String exactSearchPostURL =
      "https://maps.googleapis.com/maps/api/place/findplacefromtext/json";
  final String nearbyPostURL =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json";
  final String photoPostURL =
      "https://maps.googleapis.com/maps/api/place/photo";

  Future<List<Spot>> nearbySearch(String keyword) async {
    // if (currentLocation == null) {
    // throw "Nearby search without location perms";
    // }
    currentLocation ??= await location.getLocation();

    String call = nearbyPostURL + "?keyword=$keyword%22skatepark";
    call +=
        "&location=${currentLocation!.latitude},${currentLocation!.longitude}";
    call += "&radius=$searchRadius";
    call += "&key=$apiKey";

    log(call);

    Response res = await get(Uri.parse(call));
    if (res.statusCode == 200) {
      Map<String, dynamic> decoded = jsonDecode(res.body);
      List<dynamic> body = decoded['results'];

      // for (var entry in body) {
      // if (entry == null) body.remove(entry);
      // }
      List<Spot> spots = body.map(
        (item) {
          return Spot.fromJson(item, apiKey);
        },
      ).toList();
      return spots;
    } else {
      throw "Unable to retrieve posts";
    }
  }
}
