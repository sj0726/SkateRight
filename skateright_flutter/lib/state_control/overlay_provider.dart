import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OverlayProvider extends ChangeNotifier {
  /// Internal, private state of spots.
  bool _isDisplayed = false;

  /// An unmodifiable view of the items in the cart.
  bool get isDisplayed => _isDisplayed;

  bool toggle() {
    log('WARNING - Calls to toogle are discouraged');
    _isDisplayed = !_isDisplayed;
    notifyListeners();
    return _isDisplayed;
  }

  bool hide() {
    _isDisplayed = false;
    notifyListeners();
    return false;   // Needed for willPopScope() use
  }

  void show() {
    _isDisplayed = true;
    notifyListeners();
  }
}
