import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:convert';

// List<Spot> spotFromJson(String str, String apiKey) => List<Spot>.from(
//     json.decode(str).map((item) => Spot.fromJson(item, apiKey)));

/// Model for a skate spot. Can contain an optional list of [Comment]s
/// if users have submitted comments on the spot
///
/// Used in building spot card popups in map icon onTap()
class Spot {
  const Spot({
    this.id = "0", // TODO: Set to required once infrastructure in place
    required this.title,
    this.address,
    required this.latitude,
    required this.longitude,
    this.isPark = false,
    required this.pictures,
    this.score,
    required this.comments,
    required this.obstacles,
  });

  final String id;
  final String title;
  final double latitude;
  final double longitude;
  final bool isPark;

  final String? address;
  final List<String> pictures;

  /// Nullable & optional
  final double? score;
  final List<Comment> comments;
  final List<String> obstacles;

  // Instance method to add spot to Firebase's Realtime Database
  bool addToDatabase() {
    DatabaseReference _ref = FirebaseDatabase.instance.ref().child("Spots");
    // _ref.set("HI");
    DatabaseReference newSpot = _ref.push();
    newSpot.set({
      "id": id,
      "title": title,
      "score": score,
      // "comments": comments, // problematic.. comment data type needs to be converted into JSON-friendly text/list
      "pictures": pictures
    });
    return true;
  }

  factory Spot.fromJson(Map<String, dynamic> json, String apiKey) {
    List<String> photos = [];
    if (json['pictures'] != null) {
      for (var pic in json['pictures']) {
        photos.add(
            "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=" +
                pic['photo_reference'] +
                "&key=" +
                apiKey);
      }
    }

    List<Comment> comments = [];
    if (json.containsKey('comments')) {
      for (var comment in json['comments']) {
        comments.add(Comment(
          id: ((json['lat'] * 20).ceil()).toString(),
          user: ((json['long'] * 40).ceil()).toString(),
          description: comment,
        ));
      }
    }

    List<String> obstacles = [];
    if (json.containsKey('obstacles')) ;
    for (var ob in obstacles) {
      obstacles.add(ob.toString());
    }

    return Spot(
      id: json.containsKey('id') ? json['id'] : json['title'],
      title: json['title'],
      address: json.containsKey('address') ? json['address'] : null,
      latitude: json['lat'],
      longitude: json['long'],
      isPark: json.containsKey('isPark') ? json['isPark'] : true,
      pictures: photos,
      comments: comments,
      obstacles: obstacles,
      score: json.containsKey('score') ? json['score'].toDouble() : null,
    );

    /*
    // OLD -- From getGoogleNearby()
    List<String> photos = [];
    if (json['photos'] != null) {
      for (var picture in json['photos']) {
        photos.add(
            "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=" +
                picture['photo_reference'] +
                "&key=" +
                apiKey);
      }
    }

    return Spot(
      id: json['place_id'],
      title: json['name'],
      address: json.containsKey('vicinity') ? json['vicinity'] : null,
      latitude: json['geometry']['location']['lat'],
      longitude: json['geometry']['location']['lng'],
      isPark: true,
      pictures: photos,
      comments: [],
      obstacles: [],
    );
    */
  }
}

/// An individual review model, used within a [Spot].
class Comment {
  Comment(
      {required this.id,
      required this.user,
      this.description = '',
      this.isReview = false, // Post is default a comment
      this.score // Nullable
      });

  /// The id of the comment itself
  final String id;

  /// The id of the user who posted
  final String user;

  /// Text value of comment (what the user is saying about the spot)
  final String description;

  /// Indicates whether the comment on the spot contains a /5 score
  final bool isReview;

  /// Score if isReview
  final int? score;
}
