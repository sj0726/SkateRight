import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class SkateLocation extends StatefulWidget {
  @override
  _SkateLocationState createState() => _SkateLocationState();
}

class _SkateLocationState extends State<SkateLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skate Locations'),
      ),
      body: const MyCustomForm(),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final firestoreInstance = FirebaseFirestore.instance;
  TextEditingController latController = TextEditingController();
  TextEditingController longController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  Future<void> nearbyCall(double lat, double long, int radius) async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('getGoogleNearbyOnCall');
    final resp = await callable.call(<String, dynamic>{
      'latitude': lat,
      'longitude': long,
      'keyword': 'skate',
      // 'radius': 5000,
    });
    print(
        "nearby result: ${resp.data['results'][0]['photos'][0]['photo_reference']}");
  }

  Future<void> textCall(String query) async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('getGoogleTextSearchOnCall');
    final resp = await callable.call(<String, dynamic>{
      'query': query,
    });
    print("text result: ${resp.data}");
  }

  Future<void> photoCall(String photo_reference) async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('getGooglePlacePhotosOnCall');
    final resp = await callable.call(<String, dynamic>{
      'maxwidth': 400,
      'photo_reference': photo_reference,
    });
    print("photo result: ${resp.data}");
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Latitude',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty || !isNumeric(value)) {
                return 'Please enter valid latitude. (float)';
              }
              return null;
            },
            controller: latController,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Longitude',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty || !isNumeric(value)) {
                return 'Please enter valid Longitude. (float)';
              }
              return null;
            },
            controller: longController,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter valid name. (string)';
              }
              return null;
            },
            controller: nameController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Processing Data to Firebase..')),
                  );
                  // DatabaseReference _ref =
                  //     FirebaseDatabase.instance.ref().child("Spots");
                  // _ref.push().set({
                  //   "latitude": double.parse(latController.text),
                  //   "longitude": double.parse(longController.text),
                  //   "name": nameController.text
                  // });
                  // firestoreInstance.collection("Coordinates").add({
                  //   "latitude": double.parse(latController.text),
                  //   "longitude": double.parse(longController.text),
                  //   "name": nameController.text
                  // }).then((value) => firestoreInstance
                  //     .collection("Coordinates")
                  //     .doc(value.id)
                  //     .update({"id": value.id}));

                  // firestoreInstance.collection("Coordinates").doc(ref2).update({
                  //   "id": ref2,
                  // });
                  nearbyCall(double.parse(latController.text),
                      double.parse(longController.text), 1500);
                  // textCall(nameController.text);
                  photoCall(
                      'Aap_uEC8mJ-0ljVlzu7qtj7183b76-XLYV8nO_QRKIR9xnjVa-D2l7BQfrSbPENyp_UvDWF8JeAaFPStTZ3STTKbPH6nOXsZHV098i_kmp3GAql6lO-C_X6dOBUSWZUvV9w-YI8ovymRcki4D1BjAatkftNOGrty7eEuWKS8aeW8Y9iNp-UM');
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
