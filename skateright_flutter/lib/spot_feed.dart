import 'package:flutter/material.dart';

class SpotFeed extends StatelessWidget {
  const SpotFeed({Key? key, this.pictures}) : super(key: key);

  final List<String>? pictures;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 240,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: ListView(
              // padding: const EdgeInsets.symmetric(horizontal: 40),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                for (final pic in pictures!) _SpotPictureTile(picture: pic),
              ],
            )));

    // return ListView.builder(
    // shrinkWrap: true,
    // scrollDirection: Axis.horizontal,
    // itemCount: pictures.length,
    // itemBuilder: (context, index) => Image.network(pictures[index])
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