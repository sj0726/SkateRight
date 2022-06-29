import 'dart:developer';

import 'package:location/location.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../entities/spot.dart';

/* ----------------- THIS FILE TO BE REPLACED BY FIREBACE INSTANCE ---------------- */
/*                     IF MUST BE USED REPLACE [apiKey] with key                    */

/// WILL NOT BE USED IN FINAL BUILD
class PlacesInterface {
  PlacesInterface({required this.location});

  final Location location;
  LocationData? currentLocation;
  String? prevQuery;
  List<Spot>? prevResult;

  /// ATTN SANJOON:
  /// future plans will have a variable/sliding searchRadius
  ///   - define backend calls as dynamic in searchtem & radius (with cap)
  final int searchRadius = 5000;
  final String apiKey = "AIzaSyBGiyH12S9SDH7Pn9AdFbRRvYG8WF4DCy0";
  final String exactSearchPostURL =
      "https://maps.googleapis.com/maps/api/place/findplacefromtext/json";
  final String nearbyPostURL =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json";
  final String photoPostURL =
      "https://maps.googleapis.com/maps/api/place/photo";

  Future<List<Spot>> nearbySearch(
      {String? keyword, int? searchRadius = 5000}) async {
    // Optimization tweak cuz otherwise FSB makes like 3 calls per submit
    if (prevResult != null && keyword == prevQuery) {
      return prevResult!;
    }

    currentLocation ??= await location.getLocation();
    log("getLocation() obtained");

    String call = nearbyPostURL +
        ((keyword != null)
            ? "?keyword=$keyword%22skatepark"
            : '?keyword=skatepark');
    call +=
        "&location=${currentLocation!.latitude},${currentLocation!.longitude}";
    call += "&radius=$searchRadius";
    call += "&key=$apiKey";
    log('call: $call');

    Response res = await get(Uri.parse(call));
    if (res.statusCode == 200) {
      Map<String, dynamic> decoded = jsonDecode(res.body);
      List<dynamic> body = decoded['results'];

      List<Spot> spots = body.map(
        (item) {
          return Spot.fromJson(item, apiKey);
        },
      ).toList();

      // Optimization setup
      prevQuery = keyword;
      prevResult = spots;

      return spots;
    } else {
      throw "Unable to retrieve posts";
    }
  }
}
