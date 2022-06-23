import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import '/styles/skate_theme.dart';
import '../entities/spot.dart';
import 'review_card.dart';
import '../spot_page/reviews_page.dart';
import '../spot_page/spot_feed.dart';

class SpotPopupCard extends StatelessWidget {
  const SpotPopupCard({Key? key, required this.spot}) : super(key: key);
  final Spot spot;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Hero(
      tag: spot.id,
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Dismissible(
          key: Key('spotPage'),
          direction: DismissDirection.down,
          onDismissed: (_) => Navigator.pop(context),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: height * 0.75,
              minHeight: height * 0.3,
            ),
            child: Material(
              // No rounded border :(
              // borderRadius: const BorderRadius.only(
              // topLeft: Radius.circular(12.0),
              // topRight: Radius.circular(12.0),
              // ),
              color: Theme.of(context).backgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    // Begin Spot info widgets
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _DetailsAndPhoto(spot: spot),
                      const SizedBox(height: 10),

                      const _Interactions(),
                      const SizedBox(height: 24),

                      _Obstacles(), // Call with spot
                      const SizedBox(height: 24),

                      _SpotReviews(reviews: spot.comments),
                      const SizedBox(height: 12),

                      _ToReviews(spot: spot),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailsAndPhoto extends StatelessWidget {
  const _DetailsAndPhoto({Key? key, required this.spot}) : super(key: key);

  final Spot spot;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
            child: _SpotTitle(
              spot: spot,
            ),
            flex: 3),
        if (spot.pictures.isNotEmpty) ...[
          Flexible(
            flex: 2,
            // child: Padding(
            // Consider changing padding scheme to flexible + middle child in row
            // padding: const EdgeInsets.only(left: 32),
            child: _SpotPhoto(spot: spot),
          ),
          // ),
        ],
      ],
    );
  }
}

class _SpotTitle extends StatelessWidget {
  const _SpotTitle({Key? key, required this.spot}) : super(key: key);

  final double colPadding = 4.0;
  final Spot spot;
  final TextStyle style = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.white,
      fontStyle: FontStyle.normal);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          spot.title,
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.left,
        ),
        SizedBox(height: colPadding),
        Text(
          spot.isPark ? 'Skate Park' : 'Street Spot',
          style:
              Theme.of(context).textTheme.headline2!.copyWith(color: sYellow),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: colPadding),
        RichText(
            text: TextSpan(
          children: [
            WidgetSpan(
              child: Icon(
                Icons.location_pin,
                color: Colors.grey,
                size: 20,
              ),
            ),
            TextSpan(
              text: (spot.address ?? "Address"),
              style: Theme.of(context).textTheme.bodyText1,
              // textAlign: TextAlign.left,
            ),
          ],
        ))
      ],
    );
  }
}

class _SpotPhoto extends StatelessWidget {
  const _SpotPhoto({Key? key, required this.spot}) : super(key: key);

  final Spot spot; // Guaranteed non-null due to check in caller

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: spot.isPark
          ? Image.network(
              spot.pictures[0],
              fit: BoxFit.cover,
            )
          : Image.asset(
              // image: NetworkImage(spot.pictures![0]),
              spot.pictures[0],
              fit: BoxFit.cover,
            ),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SpotFeed(spot: spot)),
        )
      },
    );
  }
}

class _Interactions extends StatelessWidget {
  const _Interactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(
          Icons.favorite_border_outlined,
          color: Colors.red,
          size: 30,
        ),
        SizedBox(width: 12),
        Icon(
          Icons.star_border_outlined,
          color: Colors.green,
          size: 30,
        ),
        SizedBox(width: 12),
        Icon(
          Icons.photo_camera_outlined,
          color: Colors.grey,
          size: 30,
        )
      ],
    );
  }
}

class _Obstacles extends StatelessWidget {
  const _Obstacles({Key? key}) : super(key: key);

  // final List<String> obstacles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Obstacles',
          style: Theme.of(context).textTheme.headline2,
        ),
        const SizedBox(height: 8),
        Row(
          children: const [
            Icon(
              Icons.landscape_outlined,
              color: Colors.blueAccent,
              size: 30,
            ),
            SizedBox(width: 12),
            Icon(
              Icons.square_outlined,
              color: Colors.blueAccent,
              size: 30,
            ),
            SizedBox(width: 12),
            Icon(
              Icons.circle_outlined,
              color: Colors.blueAccent,
              size: 30,
            )
          ],
        ),
      ],
    );
  }
}

class _ToReviews extends StatelessWidget {
  const _ToReviews({Key? key, required this.spot}) : super(key: key);

  final Spot spot;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      //   child: Padding(
      //     padding: EdgeInsets.only(
      //       left: 12,
      //     ),
      child: ElevatedButton(
        child: const Text(
          "More Reviews",
          // style: Theme.of(context)
          // .textTheme
          // .headline2!
          // .copyWith(color: Theme.of(context).accentColor)
        ),
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ReviewsPage(spot: spot)),
          )
        },
      ),
    );
    //   ),
    // );
  }
}

/// Supposed to layout a grid of 4 reviews but it's giving a OOB range error
/// so it's not being used
class _SpotReviews extends StatelessWidget {
  const _SpotReviews({Key? key, required this.reviews}) : super(key: key);

  final List<Comment> reviews;

  // Not Working ??
  List<ReviewCard> _buildReviewCards() {
    int i = 0;
    int size = reviews.length;
    List<ReviewCard> li = [];
    while (i < size && i < 2) {
      li.add(ReviewCard(review: reviews[i++]));
    }
    return li;
  }

  @override
  Widget build(BuildContext context) {
    int x = reviews.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reviews',
          style: Theme.of(context).textTheme.headline2,
          textAlign: TextAlign.start,
        ),
        if (reviews == null) ...[
          Text("No Reviews Yet", style: Theme.of(context).textTheme.subtitle2)
        ] else ...[
          ..._buildReviewCards()
        ]
      ],
    );
  }
}
