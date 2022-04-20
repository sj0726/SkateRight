import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:location/location.dart';

import 'spot.dart';
import 'places_interface.dart';

import 'fake_spot.dart';

List<String> options = ['Park', 'Street', 'Ramps', 'Flat', 'Rails'];
Map<String, int> selections = {};

class SearchBar extends StatefulWidget {
  const SearchBar(
      {Key? key,
      required this.placeSpotMarker,
      required this.goToSpot,
      required this.location})
      : super(key: key);
  final placeSpotMarker;
  final goToSpot;
  final Location location;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late FloatingSearchBarController _controller;
  // functions from [map_page]
  late final addSpotMarker;
  late final goToSpot;
  late final PlacesInterface placeCaller;

  String query = '';
  bool makeAPICall = false;

  @override
  void initState() {
    super.initState();
    _controller = FloatingSearchBarController();
    addSpotMarker = widget.placeSpotMarker;
    goToSpot = widget.goToSpot;
    placeCaller = PlacesInterface(location: widget.location);

    for (String opt in options) {
      selections[opt] = 1; // Note: this is bad for desired stair implementation
    }
    selections['Park'] = 0; // Used for demo day 4/20 to showcase API calls
  }

  StatefulBuilder _advSearchBuilder() {
    Size size = MediaQuery.of(context).size;

    return StatefulBuilder(
      // Allows checkboxes to update state
      builder: (BuildContext context, StateSetter setState) {
        return FractionallySizedBox(
          heightFactor: .60,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: size.height / size.width * 2,
              children: selections.keys.map(
                (key) {
                  // For each search option, generate checkbox
                  return CheckboxListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    title: Text(key),
                    value: selections[key] == 1 ? true : false,
                    onChanged: (flag) {
                      setState(
                        () => selections[key] = flag! ? 1 : 0,
                      );
                    },
                  );
                },
              ).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      backgroundColor: Colors.grey[200],
      // backgroundColor: Theme.of(context).primaryColorLight,
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
        setState(() => query = input);
      },
      onSubmitted: (input) {
        query = input; // Not necesary due to onQueryChanged ?
        makeAPICall = true;
        FocusManager.instance.primaryFocus?.unfocus();
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        /* Advanced search menu */
        FloatingSearchBarAction(
          showIfOpened: true,
          showIfClosed: true,
          child: CircularButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0)),
                ),
                backgroundColor: Theme.of(context).cardColor,
                builder: (context) => _advSearchBuilder(),
              );
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          // Note: does not remove keyboard from screen
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Material(
            color: Colors.grey[50],
            elevation: 4.0,
            child: Container(
              width: double.infinity,
              child: query.isEmpty
                  ? Column(children: [])
                  : FutureBuilder(
                      future: _getResultsFromQuery(query),
                      builder: (context, AsyncSnapshot<List<Spot>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            log('error = ${snapshot.error}');
                            return Text(snapshot.error.toString());
                          }
                          return _buildSearchResults(snapshot.data!);
                        } else {
                          return const SizedBox(height: 36,
                          child: Center(
                            child: SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator()),
                          ),);
                        }
                      },
                    ),
              // Column(
              //   mainAxisSize: MainAxisSize.min,
              //   children: query.isEmpty ? [] : _buildSearchResults(),
              // ),
            ),
          ),
        );
      },
    );
  }

  Column _buildSearchResults(List<Spot> results) {
    // List<Spot> results =
    //     _getResultsFromQuery(query); // MUST COMPLETE BEFORE BUILDING
    List<ListTile> tiles = [];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (Spot result in results) ...[
          ListTile(
            title: Text(result.title),
            leading: const Icon(Icons.location_on),
            onTap: () {
              _controller.close();
              goToSpot(result);
            },
            tileColor: Colors.grey[200],
            hoverColor: Colors.grey[300],
            selectedTileColor: Colors.grey[400],
          ),
        ],
      ],
    );
  }

  Future<List<Spot>> _getResultsFromQuery(String query) async {
    /// ATTENTION SANJOON
    /// Compile database/API calls into list and return as spots

    if (selections['Park'] == 0 || makeAPICall == false) {
      return [fakeSpot, fakeSpot1];
    } else {
      return placeCaller.nearbySearch(query);
    }
  }
}
