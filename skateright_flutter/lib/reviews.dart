import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:skateright_flutter/styles/skate_theme.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create review',
      theme: skateTheme,
      home: const Scaffold(
        body: CreateReviewForm(),
        backgroundColor: Color(0xFF141414),
      ),
    );
  }
}

class CreateReviewForm extends StatefulWidget {
  const CreateReviewForm({Key? key}) : super(key: key);

  @override
  State<CreateReviewForm> createState() => _CreateReviewForm();
}

class _CreateReviewForm extends State<CreateReviewForm>{
  List<double> difficulty = [];
  List<double> safety = [];
  List<double> quality = [];
  List<double> friendliness = [];
  List<double> crowdLevel = [];
  TextEditingController addReview = TextEditingController();

  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Rate [name of skatepark]", // TODO: get name of skatepark from DB
                  style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 18
                  ),
                ),
              ),

              const Padding(
                  padding: EdgeInsets.all(8.0),
                child: Text(
                  "Difficulty",
                  style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 18
                  ),
                ),
              ),
              RatingBar(
                onRatingUpdate: (double value) {
                  difficulty.add(value);
                },
                allowHalfRating: false,
                itemCount: 5,
                direction: Axis.horizontal,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                ratingWidget: RatingWidget(
                    full: Image.asset('assets/starburst_no_outline.png'),
                    half: Image.asset('assets/starburst_no_outline.png'),
                    empty: Image.asset('assets/starbusrt_onlyoutline.png')
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Safety",
                  style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 18
                  ),
                ),
              ),
              RatingBar(
                onRatingUpdate: (double value) {
                  safety.add(value);
                },
                allowHalfRating: false,
                itemCount: 5,
                direction: Axis.horizontal,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                ratingWidget: RatingWidget(
                    full: Image.asset('assets/starburst_no_outline.png'),
                    half: Image.asset('assets/starburst_no_outline.png'),
                    empty: Image.asset('assets/starbusrt_onlyoutline.png')
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Quality",
                  style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 18
                  ),
                ),
              ),
              RatingBar(
                onRatingUpdate: (double value) {
                  quality.add(value);
                },
                allowHalfRating: false,
                itemCount: 5,
                direction: Axis.horizontal,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                ratingWidget: RatingWidget(
                    full: Image.asset('assets/starburst_no_outline.png'),
                    half: Image.asset('assets/starburst_no_outline.png'),
                    empty: Image.asset('assets/starbusrt_onlyoutline.png')
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Friendliness",
                  style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 18
                  ),
                ),
              ),
              RatingBar(
                onRatingUpdate: (double value) {
                  friendliness.add(value);
                },
                allowHalfRating: false,
                itemCount: 5,
                direction: Axis.horizontal,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                ratingWidget: RatingWidget(
                    full: Image.asset('assets/starburst_no_outline.png'),
                    half: Image.asset('assets/starburst_no_outline.png'),
                    empty: Image.asset('assets/starbusrt_onlyoutline.png')
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Crowd Level",
                  style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 18
                  ),
                ),
              ),
              RatingBar(
                onRatingUpdate: (double value) {
                  crowdLevel.add(value);
                },
                allowHalfRating: false,
                itemCount: 5,
                direction: Axis.horizontal,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                ratingWidget: RatingWidget(
                    full: Image.asset('assets/starburst_no_outline.png'),
                    half: Image.asset('assets/starburst_no_outline.png'),
                    empty: Image.asset('assets/starbusrt_onlyoutline.png')
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Add a review!",
                  style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 18
                  ),
                ),
              ),
              TextFormField(
                controller: addReview,
                cursorColor: const Color(0xFF94B321),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFf0e6d0))
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF94B321))
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero)
                    ),
                    labelText: "Review",
                    labelStyle: TextStyle(
                        color: Color(0xFFf0e6d0)
                    ),
                  )
              ),

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: ElevatedButton(
                          onPressed: () {
                            DatabaseReference _ref =
                                FirebaseDatabase.instance.ref().child("Ratings");
                            _ref.push().set({
                              "Difficulty": difficulty,
                              "Safety": safety,
                              "Quality": quality,
                              "Friendliness": friendliness,
                              "Crowd Level": crowdLevel,
                              "Review": addReview.text
                            }); // TODO: clear lists
                            firestoreInstance.collection("Ratings").add({
                              "Difficulty": difficulty,
                              "Safety": safety,
                              "Quality": quality,
                              "Friendliness": friendliness,
                              "Crowd Level": crowdLevel,
                              "Review": addReview.text
                            }); // TODO: clear lists
                          },
                          child: const Text(
                            "Done",
                            style: TextStyle(color: Color(0xFF141414)),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFFf1c200),
                              textStyle: const TextStyle(fontFamily: 'Karla')
                          ),
                        )
                    )
                  ],
                ),
              )

            ],
          )
        )
      ],
    );
  }
}