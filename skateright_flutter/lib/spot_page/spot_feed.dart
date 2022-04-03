import 'package:flutter/material.dart';
import '../spot.dart';

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
        padding: EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            for (final pic in pictures!) ...[
              SizedBox(height: 24.0),
              _SpotPictureTile(picture: pic),
            ],
            // Box at the end so users can see the last image at the top
            // of the screen if desired
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            )
          ],
        ),
      ),
    );
  }
}

class _SpotPictureTile extends StatelessWidget {
  const _SpotPictureTile({Key? key, required this.picture}) : super(key: key);

  final String picture;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage(picture),
      fit: BoxFit.fill,
    );
  }
}
