import 'package:flutter/material.dart';
import '../entities/spot.dart';

class SpotInfoPage extends StatelessWidget {
  const SpotInfoPage({Key? key, required this.spot}) : super(key: key);

  final Spot spot;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(flex: 2, child: _SpotInfo(title: spot.title)),
                  Flexible(
                      flex: 1,
                      child: Center(child: _SpotPhoto(pic: spot.pictures[0]))),
                ],
              ),
              const SizedBox(height: 12),
              _SpotInteractions(),
              const SizedBox(
                height: 18,
              ),
              _Obstacles(),
            ],
          ),
        ),
      ),
    );
  }
}

// For now only shows title
class _SpotInfo extends StatelessWidget {
  const _SpotInfo({Key? key, required this.title}) : super(key: key);

  final String title;
  final TextStyle style = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.white,
      fontStyle: FontStyle.normal);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: this.style,
          textAlign: TextAlign.left,
        ),
      ),
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          'Type of location',
          style: this.style,
          textAlign: TextAlign.left,
        ),
      ),
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Address",
          style: this.style,
          textAlign: TextAlign.left,
        ),
      ),
    ]);
  }
}

class _SpotPhoto extends StatelessWidget {
  const _SpotPhoto({Key? key, required this.pic}) : super(key: key);

  final String? pic;

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        child: Image(
          image: NetworkImage(pic!),
          fit: BoxFit.cover,
          // height: 24,
          // width: 12,

          // fit: BoxFit.cover,
        ));
  }
}

class _Obstacles extends StatelessWidget {
  const _Obstacles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Obstacles',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
            fontStyle: FontStyle.normal,
          ),
        ),
        Row(
          children: [
            const Icon(Icons.access_alarm, color: Colors.blueAccent),
            const SizedBox(width: 12),
            const Icon(
              Icons.square_outlined,
              color: Colors.blueAccent,
            ),
            const SizedBox(width: 12),
            const Icon(Icons.circle_outlined, color: Colors.blueAccent)
          ],
        ),
      ],
    );
  }
}

class _SpotInteractions extends StatelessWidget {
  const _SpotInteractions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.favorite_border_outlined, color: Colors.red),
        const SizedBox(width: 12),
        const Icon(Icons.star_border_outlined, color: Colors.green),
        const SizedBox(width: 12),
        const Icon(Icons.photo_camera_outlined, color: Colors.grey)
      ],
    );
  }
}
