import 'package:flutter/material.dart';
import 'map/map_page.dart';
import "./cookie_clicker.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:skateright_flutter/profile.dart';
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

  // final PageStorageBucket bucket = PageStorageBucket();

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: IndexedStack(children: pageList, index: _pageIndex),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Theme.of(context).primaryColorDark,
              type: BottomNavigationBarType.fixed,
              currentIndex: _pageIndex,
              onTap: _onNavigationTap,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Map'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_sharp), label: 'User'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: 'Profile'),
              ],
            ),
          );
        }
      },
    );
    //   resizeToAvoidBottomInset: false,
    //   body: PageStorage(  /// Saves state of pages... no reload required
    //     child: pageList[_pageIndex],
    //     bucket: bucket,
    //   ),
    //   bottomNavigationBar: BottomNavigationBar(
    //     // All styling info stored in skate_theme
    //     currentIndex: _pageIndex,
    //     onTap: (int index) => setState(() => _pageIndex = index),
    //     items: const <BottomNavigationBarItem>[
    //       BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Spots'),
    //       BottomNavigationBarItem(icon: Icon(Icons.cookie), label: 'Clicker'),
    //     ],
    //   ),
    // );
  }
}
