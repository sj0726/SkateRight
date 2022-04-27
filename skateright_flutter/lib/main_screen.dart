import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:skateright_flutter/profile.dart';
import './map_page.dart';
import './cookie_clicker.dart';
import './profile.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Future<FirebaseApp> _future = Firebase.initializeApp();
  @override
  int _pageIndex = 0;
  List<Widget> pageList = <Widget>[
    MapPage(key: PageStorageKey('Map')),
    ClickerPage(key: PageStorageKey('Clicker')),
    ProfilePage(key: PageStorageKey('Profile')),
  ];

  void _onNavigationTap(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  final PageStorageBucket bucket = PageStorageBucket();

  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return Scaffold(
                  body: pageList[_pageIndex],
                  bottomNavigationBar: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    currentIndex: _pageIndex,
                    onTap: _onNavigationTap,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                          icon: Icon(Icons.map_outlined), label: 'Map'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.skateboarding), label: 'User'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.rounded_corner_rounded), label: 'Profile'),
                    ],
                  ),
                );
              }
            }));
  }
}
