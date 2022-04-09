import 'package:flutter/material.dart';
import "./map_page.dart";
import "./cookie_clicker.dart";
import 'package:firebase_core/firebase_core.dart';
// import 'package:quotes_app/home.dart';
// import 'package:quotes_app/characters_page.dart';
// import 'package:quotes_app/favorites.dart';

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
                    ],
                  ),
                );
              }
            })
        // body: pageList[_pageIndex],
        // bottomNavigationBar: BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   currentIndex: _pageIndex,
        //   selectedItemColor: Colors.purple[600],
        //   onTap: _onNavigationTap,
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Spots'),
        //     BottomNavigationBarItem(icon: Icon(Icons.cookie), label: 'Clicker'),
        //   ],
        // ),
        );
  }
}
