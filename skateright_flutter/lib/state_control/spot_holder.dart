import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:collection';
import 'package:skateright_flutter/entities/spot.dart';
import 'package:skateright_flutter/map/fake_spot.dart';

class SpotHolder extends ChangeNotifier {
  SpotHolder(this._heldSpots);

  /// Internal, private state of spots.
  final List<Spot> _heldSpots;

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Spot> get heldSpots => UnmodifiableListView(_heldSpots);

  /// Adds [spot] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Spot spot) {
    _heldSpots.add(spot);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Adds multiple spots from a list
  void addSpots(List<Spot> spots) {
    int numSpots = _heldSpots.length;
    _heldSpots.addAll(spots);

    // Check to make sure a change has been made before sending notification
    if (_heldSpots.length != numSpots) {
      notifyListeners();
    }
  }

  /// Removes all items from the cart.
  void removeAll() {
    _heldSpots.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  List<Spot> getSpots() {
    return _heldSpots;
  }
}


/**
 * Notes from documentation:
 * 
 * notifyListeners()
 *   - Call this method any time the model changes in a way that might change your app’s UI.
 */