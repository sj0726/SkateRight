import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skateright_flutter/entities/spot.dart';
import '../state_control/spot_holder.dart';
import './review_card.dart';
import 'package:skateright_flutter/spot_editing/create_review.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({Key? key}) : super(key: key);


  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  // late Spot spot;

  @override
  void initState() {
    super.initState();

    // spot = widget.spot;
  }

  @override
  Widget build(BuildContext context) {
    Spot spot = Provider.of<SpotHolder>(context, listen: false).currentSpot!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          spot.title,
          textAlign: TextAlign.center,
        ),
      ), //style: Theme.of(context).textTheme.headline1,),

      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20),
        // child: SingleChildScrollView(
        child: ListView(
          children: [
            Text("Reviews", style: Theme.of(context).textTheme.headline1),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.add),
              title: Text(
                "Add a Review",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreateReviewForm(),
              )),
            ),
            const SizedBox(height: 12),
            for (final review in Provider.of<SpotHolder>(context).currentSpot!.comments) ReviewCard(review: review)
          ],
        ),
      ),
      // ),
    );
  }
}
