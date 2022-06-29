import 'dart:developer' as dev;
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import '/styles/skate_theme.dart';
import '../entities/spot.dart';
import 'review_card.dart';
import '../spot_page/reviews_page.dart';
import '../spot_page/spot_feed.dart';
import '../entities/obstacles.dart';

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
              child: SingleChildScrollView(
                // physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Column(
                    // Begin Spot info widgets
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _DetailsAndPhoto(spot: spot),
                      const SizedBox(height: 10),

                      // const _Interactions(),
                      // const SizedBox(height: 24),

                      // if (spot.obstacles.isNotEmpty) ...[
                      _DisplayObstacles(
                          obstacles: spot.obstacles), // Call with spot
                      const SizedBox(height: 24),
                      // ],
                      if (spot.comments.isNotEmpty) ...[
                        _SpotReviews(reviews: spot.comments),
                        const SizedBox(height: 12),
                      ],

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
    var size = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.topLeft,
        height: size.height / 6,
        child: Stack(
          children: [
            // Container(
            //     width: size.width / 2,
            //     height: double.infinity,
            OverflowBox(
                alignment: Alignment.centerLeft,
                minHeight: size.height / 8,
                maxHeight: size.height / 4,
                maxWidth: size.width / 2,
                minWidth: size.width / 2,
                child: _SpotTitle(spot: spot)),
            if (spot.pictures.isNotEmpty) ...[
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                    width: size.width * 2,
                    height: double.infinity,
                    child: _SpotPhoto(spot: spot)),
              ),
            ]
          ],
        ));

    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 5,
          child: _SpotTitle(
            spot: spot,
          ),
        ),
        if (spot.pictures.isNotEmpty) ...[
          Flexible(flex: 1, child: Container()),
          Flexible(
            flex: 4,
            child: Align(
              alignment: Alignment.centerRight,
              child: _SpotPhoto(spot: spot),
            ),
          ),
        ],
      ],
    ));
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
    return
        // FittedBox(
        //   fit: BoxFit.fitHeight,
        //   child:
        Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
            const WidgetSpan(
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
      // )
    );
  }
}

class _SpotPhoto extends StatelessWidget {
  const _SpotPhoto({Key? key, required this.spot}) : super(key: key);

  final Spot spot; // Guaranteed non-null due to check in caller

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ClipRect(
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          child: GestureDetector(
            child: spot.isPark
                ? Image.network(
                    spot.pictures[0],
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    // image: NetworkImage(spot.pictures![0]),
                    spot.pictures[0],
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  ),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SpotFeed(spot: spot)),
              )
            },
          ),
        ),
      ),
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

class _DisplayObstacles extends StatelessWidget {
  const _DisplayObstacles({Key? key, required this.obstacles})
      : super(key: key);

  final List<String> obstacles;

  @override
  Widget build(BuildContext context) {
    Obstacles obby = Obstacles();
    List<Widget> obbyList = [];
    for (String obstacle in obstacles) {
      Widget? temp = obby.loadObstacle(obstacle);
      if (temp != null) {
        obbyList.add(temp);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Obstacles',
          style: Theme.of(context).textTheme.headline2,
        ),
        const SizedBox(height: 8),
        Row(children: [
          ...obbyList,
          SizedBox(width: 15),
          _addObstaclesButton(obstacles)
        ]),
      ],
    );
  }
}

class _addObstaclesButton extends StatelessWidget {
  const _addObstaclesButton(this.selectedObstacles, {Key? key})
      : super(key: key);
  final List<String> selectedObstacles;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi * 3 / 7,
      child: Container(
        color: Theme.of(context).accentColor,
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ObstacleSelection(
                selectedObstacles: selectedObstacles,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ToReviews extends StatelessWidget {
  const _ToReviews({Key? key, required this.spot}) : super(key: key);

  final Spot spot;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      //   child: Padding(
      //     padding: EdgeInsets.only(
      //       left: 12,
      //     ),
      child: ElevatedButton(
        child: Text(
          (spot.comments.isNotEmpty) ? "More Reviews" : "Add A Review",
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

class ObstacleSelection extends StatelessWidget {
  ObstacleSelection({
    List<String>? this.selectedObstacles,
    Key? key,
  }) : super(key: key);
  List<String>? selectedObstacles;
  final obSelects = {};

  // Converts options list into a map... note: bad for desired stair implementation

  void _initSelections() {
    // obSelects ??= {};

    for (var opt in validObstacles) {
      if (!obSelects.containsKey(opt)) {
        obSelects[opt] = 0;
      }
    }

    for (var ob in selectedObstacles ?? []) {
      obSelects[ob] = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    Obstacles obby = Obstacles();
    _initSelections();
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Add Obstacles')),
      body: Material(
        color: Theme.of(context).backgroundColor,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(top: 24, bottom: 48),
            child: StatefulBuilder(
              builder: ((context, setState) {
                return GridView.count(
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.8),
                  mainAxisSpacing: 30,
                  crossAxisCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: obSelects.keys.map((key) {
                    return GestureDetector(
                      onTap: () => setState(
                          () => obSelects[key] = ((obSelects[key] + 1) % 2)),
                      child: Container(
                        width: size.width / 7,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: obby.loadObstacle(key),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Icon(
                                  (obSelects[key] == 0)
                                      ? Icons.circle_outlined
                                      : Icons.circle,
                                  color: Theme.of(context).accentColor),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
