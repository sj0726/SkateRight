import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:skateright_flutter/spot_editing/submit_text_field.dart';
import 'package:skateright_flutter/entities/spot.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skateright_flutter/entities/obstacles.dart';

class CreateSpotPage extends StatefulWidget {
  const CreateSpotPage(
      {Key? key,
      required this.latitude,
      required this.longitude,
      required this.addSpotToMap})
      : super(key: key);

  final double latitude;
  final double longitude;
  final addSpotToMap;

  @override
  State<CreateSpotPage> createState() => _CreateSpotPageState();
}

/// Stateful only to provide access to context:
///  ^ Used for Navigator pop & alertDialog "Spot Submitted!"
class _CreateSpotPageState extends State<CreateSpotPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  late final double latitude;
  late final double longitude;

  @override
  void initState() {
    super.initState();
    latitude = widget.latitude;
    longitude = widget.longitude;
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Add New Spot"),
      ),
      body: Material(
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 16.0,
              right: 16.0,
            ),
            child: ListView(
              children: [
                const SizedBox(height: 12),
                SubmitTextField(
                  label: 'Name of Spot',
                  controller: nameController,
                ),
                const SizedBox(height: 20),
                SubmitTextField(
                    label: 'Address', controller: addressController),
                const SizedBox(
                  height: 60,
                ),
                const ObstacleSelection(),

                /*  ---------- Last Item ----------  */
                const SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .25),
                  child: ElevatedButton(
                      onPressed: () => _confirmSubmission(),
                      child: const Text("Submit Spot")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmSubmission() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).backgroundColor,
          actionsAlignment: MainAxisAlignment.spaceAround,

          title: Text(
            'Confirm Spot \"${nameController.text}\"?',
            textAlign: TextAlign.center,
          ),
          // content: Text('', textAlign: TextAlign.center),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Go Back',
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Ok',
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  Navigator.of(context).pop();
                  _submitSpot();
                } else{
                  
                }
              },
            ),
          ],
        );
      },
    );
  }

  /// ATTN SANJOON
  /// Called from submit button
  /// Sends user-entered info to backend for further processing + db submit
  void _submitSpot() {
    final firestoreInstance = FirebaseFirestore.instance;

    String? addressText =
        (addressController.text.isEmpty) ? null : addressController.text;

    List<String> spotObstacles = [];
    for (String key in obSelects.keys) {
      if (obSelects[key] != 0) {
        spotObstacles.add(key);
      }
    }

    Spot toAdd = Spot(
      // ID used should be the one automatically created by firebase
      title: nameController.text,
      address: addressText,
      latitude: latitude,
      longitude: longitude,
      pictures: [],
      comments: [],
      obstacles: spotObstacles,
    );

    final docRef = firestoreInstance.collection('SkateSpots').doc();
    final data = {
      'title': toAdd.title,
      'address': toAdd.address,
      'latitude': toAdd.latitude,
      'longitude': toAdd.longitude,
      'pictures': toAdd.pictures,
      'comments': toAdd.comments,
      'obstacles': toAdd.obstacles,
    };
    docRef.set(data);

    widget.addSpotToMap(toAdd);

    Navigator.of(context).pop();
  }
}

/* ------------- Obstacle grid builder --------------- */

/* Should be stored in a config file which loads from db on app start, see search_bar.dart */
// final List<String> obstacles = [
//   'Flat',
//   'Bowl',
//   'Ramp',
//   'Curb',
//   'Ledge',
//   'Flat Rail',
//   'Bank',
//   'Gap',
//   'Hand Rail',
//   '1/4 Pipe',
//   'Full Pipe',
//   'Stairs'
// ];
final obSelects = {};

class ObstacleSelection extends StatelessWidget {
  const ObstacleSelection({
    Key? key,
  }) : super(key: key);

  // Converts options list into a map... note: bad for desired stair implementation

  void _initSelections() {
    // obSelects ??= {};

    for (var opt in validObstacles) {
      if (!obSelects.containsKey(opt)) {
        obSelects[opt] = 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Obstacles obby = Obstacles();
    _initSelections();
    var size = MediaQuery.of(context).size;

    return StatefulBuilder(
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
              onTap: () =>
                  setState(() => obSelects[key] = ((obSelects[key] + 1) % 2)),
              child: Container(
                width: size.width / 7,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: obby.loadObstacle(key)!,
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Icon(
                            (obSelects[key] == 0)
                                ? Icons.circle_outlined
                                : Icons.circle,
                            color: Theme.of(context).accentColor))
                  ],
                ),
              ),
            );
          }).toList(),
        );
      }),
    );
  }
}
