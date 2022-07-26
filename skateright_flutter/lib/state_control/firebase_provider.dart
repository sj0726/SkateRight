import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';


/// Current belief is this is not necessary... fireXXX.instance is not async
/// ------------ NOT IN USE -----------------
class LocationProvider extends ChangeNotifier {

  final _firestore = FirebaseFirestore.instance;
  final _functions = FirebaseFunctions.instance;

  get firestore => _firestore;
  get functions => _functions;
}