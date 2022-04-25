import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './entities/spot.dart';
import 'map_page.dart';

import '../map/fake_spot.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  // final GoogleMapController mapController;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late bool expanded;
  late bool searching;
  late FloatingSearchBarController _controller;
  final firestoreInstance = FirebaseFirestore.instance;

  String query = '';

  @override
  void initState() {
    super.initState();
    _controller = FloatingSearchBarController();
    expanded = false;
    searching = false;
    // mapController = widget.mapController;
    // filteredSearchHistory = filterSearchTerms(filter: null);
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      backgroundColor: Theme.of(context).primaryColorLight,
      borderRadius: BorderRadius.circular(60),
      queryStyle:
          Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.black),
      controller: _controller,
      hint: 'Search...',
      // scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),

      onQueryChanged: (input) {
        // Changing query calls builder which handles DB querying
        query = input;
      },
      onSubmitted: (input) {
        // Closes keyboard
        FocusManager.instance.primaryFocus?.unfocus();
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              query = "";
              _controller.close();
              // _controller.hide();
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          // Note: does not clear keyboard
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: query.isEmpty ? [] : _buildSearchResults(),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildSearchResults() {
    // Idea - use a global flag  queryDone, futureBuilder, or .then()
    List<Spot> results =
        _getResultsFromQuery(query); // MUST COMPLETE BEFORE BUILDING
    List<ListTile> tiles = [];

    for (Spot result in results) {
      tiles.add(
        ListTile(
          title: Text(result.title),
          leading: const Icon(Icons.location_on),
          onTap: () => goToSpot(result),
        ),
      );
    }
    return tiles;
  }

  List<List> _commentsList(List<Comment> comments) {
    List<List> results = [];
    for (Comment comment in comments) {
      results.add([
        comment.id,
        comment.user,
        comment.description,
        comment.isReview,
        comment.score
      ]);
    }
    print(results);
    return results;
  }

  List<Spot> _getResultsFromQuery(String query) {
    /// ATTENTION SANJOON
    /// Compile database/API calls into list and return as spots

    // final docRef = firestoreInstance.collection("SearchQuery").add({
    //   "id": fakeSpot.id,
    //   "title": fakeSpot.title,
    //   "score": fakeSpot.score,
    //   "comments": _commentsList(fakeSpot.comments)[0], // TODO: fix this
    //   "pictures": fakeSpot.pictures,
    //   "obstacles": fakeSpot.obstacles,
    //   "latitude": fakeSpot.latitude,
    //   "longitude": fakeSpot.longitude,
    // });
    final docRef = firestoreInstance.collection("SearchQuery");
    Future<List<Spot>> result = docRef.get().then((snapshot) {
      List<Spot> temp = [];
      snapshot.docs.forEach((doc) {
        var data = doc.data();
        var c = Comment(
            id: data['comments'][0],
            user: data['comments'][1],
            description: data['comments'][2],
            isReview: data['comments'][3],
            score: data['comments'][4]);
        var tempComment = Spot(
            comments: [c],
            title: data['title'],
            score: data['score'],
            id: data['id'],
            latitude: data['latitude'],
            longitude: data['longitude'],
            pictures: [],
            obstacles: []);
        // pictures: data['pictures'],
        // obstacles: data['obstacles']);
        print("tempComment.id: " + tempComment.id);
        temp.add(tempComment);
        // print("result.length: " + result.length.toString());
      });
      print("result.length2: " + temp.length.toString());
      return temp;
    });
    // print("result.length: " + result.length.toString());
    return [];
  }

  // List<Spot> convertFutureListToList(Future<List<Spot>> query) async {
  //   Future<List<Spot>> _futureOfList = query;
  //   List<Spot> list = await _futureOfList;
  //   return list;
  // }

  void goToSpot(Spot spot) {
    _controller.close();

    LatLng newLatLng = LatLng(spot.latitude, spot.longitude);
    globalMapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: newLatLng, zoom: 20),
      ),
    );
    // loadSpotsAtLocation(newLatLng)
  }
}
