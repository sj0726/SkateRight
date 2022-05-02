import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:skateright_flutter/spot_editing/submit_text_field.dart';
import 'package:skateright_flutter/entities/spot.dart';

class CreateSpotPage extends StatefulWidget {
  const CreateSpotPage(
      {Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  final double latitude;
  final double longitude;

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
                Navigator.of(context).pop();
                _submitSpot();
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
    // firebaseHandler.addSpotToDatabase(toAdd);

    Navigator.of(context).pop();
    // Play goofy little check mark animation?
  }
}

/* ------------- Obstacle grid builder --------------- */

/* Should be stored in a config file which loads from db on app start, see search_bar.dart */
final List<String> obstacles = [
  'Flat',
  'Bowl',
  'Ramp',
  'Curb',
  'Ledge',
  'Flat Rail',
  'Bank',
  'Gap',
  'Hand Rail',
  '1/4 Pipe',
  'Full Pipe',
  'Stairs'
];
final obSelects = {};

class ObstacleSelection extends StatelessWidget {
  const ObstacleSelection({
    Key? key,
  }) : super(key: key);

  // Converts options list into a map... note: bad for desired stair implementation

  void _initSelections() {
    // obSelects ??= {};

    for (var opt in obstacles) {
      if (!obSelects.containsKey(opt)) {
        obSelects[opt] = 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    List<IconData> iconics = [
      Icons.square_outlined,
      Icons.circle_outlined,
      Icons.polyline,
      Icons.landscape_outlined,
      Icons.crop_square,
      Icons.texture_outlined,
      Icons.bar_chart_outlined,
      Icons.stairs_outlined,
      Icons.cloud_circle,
      Icons.cloud_outlined,
    ];
    _initSelections();
    var size = MediaQuery.of(context).size;
    return StatefulBuilder(
      builder: ((context, setState) {
        return GridView.count(
          // mainAxisSpacing: size.height / 20,
          crossAxisCount: 3,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: obSelects.keys.map((key) {
            return Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  key,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                IconButton(
                  icon: Icon(iconics[random.nextInt(iconics.length)],
                      size: 30, color: Colors.white),
                  onPressed: () => setState(() => (obSelects[key] == 1)
                      ? obSelects[key] = 0
                      : obSelects[key] = 1),
                ),
                Checkbox(
                  value: obSelects[key] == 1 ? true : false,
                  shape: CircleBorder(side: BorderSide(color: Colors.white)),
                  checkColor: Colors.transparent,
                  onChanged: (flag) {
                    setState(
                      () => obSelects[key] = flag! ? 1 : 0,
                    );
                  },
                ),
              ],
            );
          }).toList(),
        );
      }),
    );
  }
}
