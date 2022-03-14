import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import './spot.dart';
import './fake_spot.dart';
import './hero_dialog_route.dart';

void main() {
  runApp(const MapPage());
}

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Maps Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(42.350138473333864, -71.11174104622769),
    zoom: 15,
  );

  late GoogleMapController _googleMapController;
  Set<Marker> _markers = {};

  getData() async {
    /**
     TODO (Aira): 
     * GET DATA FROM DATABASE
     * Decode JSON to fit format
     * 
     *  */

    _markers.clear();
  }

  _onMarkerTap() {
    Navigator.of(context).push(
      HeroDialogRoute(
        builder: (context) => Center(
          child: _SpotPopupCard(spot: fakeSpot),
        ),
      ),
    );
  }

  void _onMapCreated(controller) async {
    // Set map controller
    _googleMapController = controller;

    // atm does nothing but clear the set of markers
    await getData();

    // TODO: turn into a loop that reads from JSON
    // see - https://stackoverflow.com/questions/67153885/how-to-add-marker-in-the-google-map-using-json-api-in-flutter
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("GSU"),
        position: LatLng(42.35111488978059, -71.10889075787007),
        // onTap: () => _onMarkerTap(),

        /// Call with ID
        infoWindow: InfoWindow(
            title: "George Sherman Union",
            snippet: "more info...",
            onTap: () => _onMarkerTap()),
      ));

      _markers.add(Marker(
        markerId: MarkerId("808"),
        position: LatLng(42.350669405851505, -71.11207366936073),
        onTap: () => _onMarkerTap(),
        // infoWindow: InfoWindow(
        // title: "808 Comm Ave INFO",
        // ),
      ));

      _markers.add(const Marker(
        markerId: MarkerId("Agganis Arena"),
        position: LatLng(42.35260646322381, -71.11782537730139),
        infoWindow: InfoWindow(
          title: "Agganis Arena INFO",
        ),
      ));
    });
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _onMapCreated(controller),
        markers: _markers,
      ),
    );
  }
}

/// Formats title of spot so it displays in bigger font
/// Used in [_SpotPopupCard]
class _SpotTitle extends StatelessWidget {
  const _SpotTitle({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18));
  }
}

/// Formats comments/reviews
/// Called by [_SpotPopupCard]
class _SpotComments extends StatelessWidget {
  const _SpotComments({Key? key, required this.comments}) : super(key: key);

  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (final cmnt in comments) _SpotCommentTile(comment: cmnt),
    ]);
  }
}

/// Formats individual comments as they appear in the list of comments
/// Called by [_SpotComments]
class _SpotCommentTile extends StatelessWidget {
  const _SpotCommentTile({Key? key, required this.comment}) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    Icon trailing = const Icon(Icons.favorite, color: Colors.transparent);
    if (comment.isReview) {
      trailing = const Icon(Icons.favorite, color: Colors.red);
    }

    return ListTile(
      leading: const Icon(Icons.person, color: Colors.blue),
      trailing: trailing,
      title: Text(comment.user),
      subtitle: Text(comment.description),
      // tileColor: Colors.grey[300],
      minVerticalPadding: 13,
    );
  }
}

class _SpotPictures extends StatelessWidget {
  const _SpotPictures({Key? key, required this.pictures}) : super(key: key);

  final List<String> pictures;

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
                for (final pic in pictures) _SpotPictureTile(picture: pic),
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

class _SpotPopupCard extends StatelessWidget {
  const _SpotPopupCard({Key? key, required this.spot}) : super(key: key);
  final Spot spot;

  @override
  Widget build(BuildContext context) {
    /// TODO: Find a way to add a RectTween to hero to get an animation to play
    /// Possible solution - wrap [_SpotPopupCard] in a Gesture widget
    ///   set onTap: this, child: rectTween
    return Hero(
      tag: spot.id,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.grey[100],
            child: SizedBox(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        _SpotTitle(title: spot.title),
                        const SizedBox(
                          height: 12,
                        ),
                        if (spot.pictures != null) ...[
                          const Divider(),
                          _SpotPictures(pictures: spot.pictures!)
                        ],
                        const SizedBox(height: 25),
                        const _SpotTitle(title: 'Comments'),
                        if (spot.comments != null) ...[
                          const Divider(),
                          _SpotComments(comments: spot.comments!),
                        ],
                      ]),
                    )))),
      ),
    );
  }
}
