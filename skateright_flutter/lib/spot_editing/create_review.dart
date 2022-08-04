import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:skateright_flutter/entities/spot.dart';
import 'package:skateright_flutter/state_control/spot_holder.dart';

alertDialog(BuildContext context) {
  // This is the ok button
  Widget ok = ElevatedButton(
    child: const Text(
      "Okay",
      style: TextStyle(color: Color(0xFF141414)),
    ),
    style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        primary: const Color.fromARGB(255, 206, 187, 19),
        textStyle: const TextStyle(fontFamily: 'Karla')),
    onPressed: () {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    },
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        title: const Text(
          "Great!",
          style: TextStyle(color: Color(0xFFf0e6d0)),
        ),
        content: const Text(
            "Your review and rating have been saved. Can't wait for your next review!"),
        actions: [ok],
        elevation: 5,
        backgroundColor: const Color(0xFF141414),
      );
    },
  );
}

class CreateReviewForm extends StatefulWidget {
  const CreateReviewForm({Key? key}) : super(key: key);

  @override
  State<CreateReviewForm> createState() => _CreateReviewForm();
}

class _CreateReviewForm extends State<CreateReviewForm> {
  List<double> difficulty = [];
  List<double> safety = [];
  List<double> quality = [];
  List<double> friendliness = [];
  List<double> crowdLevel = [];
  TextEditingController addReview = TextEditingController();

  final firestoreInstance = FirebaseFirestore.instance;

  String? spotName;
  late final Spot spot;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    spot = Provider.of<SpotHolder>(context, listen: false).currentSpot!;
    spotName = spot.title;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Material(
        color: Theme.of(context).backgroundColor,
        child: ListView(
          children: <Widget>[
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        spotName != null ? 'Rate $spotName' : 'Rate Spot',
                        style: const TextStyle(
                            fontFamily: 'RobotoMono', fontSize: 18),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Difficulty",
                        style:
                            TextStyle(fontFamily: 'RobotoMono', fontSize: 18),
                      ),
                    ),
                    RatingBar(
                      onRatingUpdate: (double value) {
                        difficulty.clear();
                        difficulty.add(value);
                      },
                      allowHalfRating: false,
                      itemCount: 5,
                      direction: Axis.horizontal,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      ratingWidget: RatingWidget(
                          full: Image.asset(
                              'assets/icons/starburst_no_outline.png'),
                          half: Image.asset(
                              'assets/icons/starburst_no_outline.png'),
                          empty: Image.asset(
                              'assets/icons/starbusrt_onlyoutline.png')),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Safety",
                        style:
                            TextStyle(fontFamily: 'RobotoMono', fontSize: 18),
                      ),
                    ),
                    RatingBar(
                      onRatingUpdate: (double value) {
                        safety.clear();
                        safety.add(value);
                      },
                      allowHalfRating: false,
                      itemCount: 5,
                      direction: Axis.horizontal,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      ratingWidget: RatingWidget(
                          full: Image.asset(
                              'assets/icons/starburst_no_outline.png'),
                          half: Image.asset(
                              'assets/icons/starburst_no_outline.png'),
                          empty: Image.asset(
                              'assets/icons/starbusrt_onlyoutline.png')),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Quality",
                        style:
                            TextStyle(fontFamily: 'RobotoMono', fontSize: 18),
                      ),
                    ),
                    RatingBar(
                      onRatingUpdate: (double value) {
                        quality.clear();
                        quality.add(value);
                      },
                      allowHalfRating: false,
                      itemCount: 5,
                      direction: Axis.horizontal,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      ratingWidget: RatingWidget(
                          full: Image.asset(
                              'assets/icons/starburst_no_outline.png'),
                          half: Image.asset(
                              'assets/icons/starburst_no_outline.png'),
                          empty: Image.asset(
                              'assets/icons/starbusrt_onlyoutline.png')),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Friendliness",
                        style:
                            TextStyle(fontFamily: 'RobotoMono', fontSize: 18),
                      ),
                    ),
                    RatingBar(
                      onRatingUpdate: (double value) {
                        friendliness.clear();
                        friendliness.add(value);
                      },
                      allowHalfRating: false,
                      itemCount: 5,
                      direction: Axis.horizontal,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      ratingWidget: RatingWidget(
                          full: Image.asset(
                              'assets/icons/starburst_no_outline.png'),
                          half: Image.asset(
                              'assets/icons/starburst_no_outline.png'),
                          empty: Image.asset(
                              'assets/icons/starbusrt_onlyoutline.png')),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Crowd Level",
                        style:
                            TextStyle(fontFamily: 'RobotoMono', fontSize: 18),
                      ),
                    ),
                    RatingBar(
                      onRatingUpdate: (double value) {
                        crowdLevel.clear();
                        crowdLevel.add(value);
                      },
                      allowHalfRating: false,
                      itemCount: 5,
                      direction: Axis.horizontal,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      ratingWidget: RatingWidget(
                          full: Image.asset(
                              'assets/icons/starburst_no_outline.png'),
                          half: Image.asset(
                              'assets/icons/starburst_no_outline.png'),
                          empty: Image.asset(
                              'assets/icons/starbusrt_onlyoutline.png')),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Add a review!",
                        style:
                            TextStyle(fontFamily: 'RobotoMono', fontSize: 18),
                      ),
                    ),
                    TextFormField(
                        // TODO: sharp corners
                        controller: addReview,
                        cursorColor: const Color(0xFF94B321),
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFf0e6d0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF94B321)),
                              borderRadius: BorderRadius.zero),
                          border: OutlineInputBorder(),
                          labelText: "Review",
                          labelStyle: TextStyle(color: Color(0xFFf0e6d0)),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              alertDialog(context);
                              DatabaseReference _ref = FirebaseDatabase.instance
                                  .ref()
                                  .child("Ratings");
                              _ref.push().set({
                                "Difficulty": difficulty,
                                "Safety": safety,
                                "Quality": quality,
                                "Friendliness": friendliness,
                                "Crowd Level": crowdLevel,
                                "Review": addReview.text
                              });
                              firestoreInstance.collection("Ratings").add({
                                "Difficulty": difficulty,
                                "Safety": safety,
                                "Quality": quality,
                                "Friendliness": friendliness,
                                "Crowd Level": crowdLevel,
                                "Review": addReview.text
                              });

                              String stupidNumber =
                                  Random().nextInt(1000).toString();
                              Provider.of<SpotHolder>(context, listen: false).addReview(
                                  Comment(
                                      id: stupidNumber,
                                      user: stupidNumber,
                                      description: addReview.text));
                            },
                            child: const Text(
                              "Done",
                              style: TextStyle(color: Color(0xFF141414)),
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero),
                                primary: const Color(0xFFf1c200),
                                textStyle:
                                    const TextStyle(fontFamily: 'Karla')),
                          ),
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
