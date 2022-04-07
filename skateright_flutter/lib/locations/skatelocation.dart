import 'package:flutter/material.dart';

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
      body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                children: const [],
              ),
          ),
      ),
    );
  }
}
