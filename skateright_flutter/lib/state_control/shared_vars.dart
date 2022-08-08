import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:location/location.dart';

/// Intended to hold all shared data (firestore, )
class SharedVars extends InheritedWidget {
  SharedVars({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final location = 0;

  final firestore = FirebaseFirestore.instance;
  final functions = FirebaseFunctions.instance;

  static SharedVars of(BuildContext context) {
    final SharedVars? result =
        context.dependOnInheritedWidgetOfExactType<SharedVars>();
    assert(result != null, 'No firestore found in context');
    return result!;
  }

  getNearbyFunction() {
    return functions.httpsCallable('getSpots');
  }

  @override
  bool updateShouldNotify(SharedVars old) => firestore != old.firestore;
  // bool updateShouldNotify(SharedVars old) => color != old.color;
}
