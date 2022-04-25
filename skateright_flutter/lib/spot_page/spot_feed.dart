import 'package:flutter/material.dart';
import '../entities/spot.dart';

class SpotFeed extends StatelessWidget {
  const SpotFeed({Key? key, required this.spot}) : super(key: key);

  final Spot spot;
  // final List<String>? pictures;

  @override
  Widget build(BuildContext context) {
    List<String>? pictures = spot.pictures;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          spot.title,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Padding(
        // See above comment block for Scaffold attrs
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            for (final pic in pictures) ...[
              // First box functions as scroll-away AppBar padding
              const SizedBox(height: 24.0),
              _SpotPictureTile(picture: pic, fromNetwork: spot.isPark),
            ],
            // Gives wiggle-room at end so users can over-scroll if desired
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
            )
          ],
        ),
      ),
    );
  }
}

class _SpotPictureTile extends StatelessWidget {
  const _SpotPictureTile(
      {Key? key, required this.picture, required this.fromNetwork})
      : super(key: key);

  final String picture;
  final bool fromNetwork;

  @override
  Widget build(BuildContext context) {
    return fromNetwork
        ? Image.network(
            picture,
            fit: BoxFit.fill,
          )
        : Image.asset(
            picture,
            fit: BoxFit.fill,
          );
  }
}
