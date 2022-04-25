import 'package:flutter/material.dart';
import 'map/map_page.dart';
import "./cookie_clicker.dart";


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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

  // final PageStorageBucket bucket = PageStorageBucket();

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(  /// Saves state of pages... no reload required
        children: pageList,
        index: _pageIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // All styling info stored in skate_theme
        currentIndex: _pageIndex,
        onTap: (int index) => setState(() => _pageIndex = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Spots'),
          BottomNavigationBarItem(icon: Icon(Icons.person_sharp), label: 'Clicker'),
        ],
      ),
    );
  }
}
