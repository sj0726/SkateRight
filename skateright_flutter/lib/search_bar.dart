import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'spot.dart';

import 'fake_spot.dart';

List<String> options = ['Park', 'Street', 'Ramps', 'Flat', 'Rails'];
Map<String, int> selections = {};

class SearchBar extends StatefulWidget {
  const SearchBar(
      {Key? key, required this.placeSpotMarker, required this.goToSpot})
      : super(key: key);
  final placeSpotMarker;
  final goToSpot;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late FloatingSearchBarController _controller;
  // functions from [map_page]
  late final addSpotMarker;
  late final goToSpot;

  String query = '';

  @override
  void initState() {
    super.initState();
    _controller = FloatingSearchBarController();
    addSpotMarker = widget.placeSpotMarker;
    goToSpot = widget.goToSpot;

    for (String opt in options) {
      selections[opt] = 1; // Note: this is bad for desired stair implementation
    }
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
        FocusManager.instance.primaryFocus?.unfocus();
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        /* Advanced search menu */
        FloatingSearchBarAction(
          showIfOpened: false,
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
          onTap: () {
            _controller.close();
            goToSpot(result);
          },
          tileColor: Colors.grey[200],
          hoverColor: Colors.grey[300],
          selectedTileColor: Colors.grey[400],
        ),
      );
    }
    return tiles;
  }

  List<Spot> _getResultsFromQuery(String query) {
    /// ATTENTION SANJOON
    /// Compile database/API calls into list and return as spots
    return [fakeSpot, fakeSpot1];
  }
}
