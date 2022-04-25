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
  @override
  int _pageIndex = 0;
  List<Widget> pageList = <Widget>[
    const MapPage(key: PageStorageKey('Map')),
    const ClickerPage(key: PageStorageKey('Clicker')),
    const ProfilePage(key: PageStorageKey('Profile')),
  ];

  void _onNavigationTap(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(  /// Saves state of pages... no reload required
        child: pageList[_pageIndex],
        bucket: bucket,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // All styling info stored in skate_theme
        currentIndex: _pageIndex,
        onTap: (int index) => setState(() => _pageIndex = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Spots'),
          BottomNavigationBarItem(icon: Icon(Icons.cookie), label: 'Clicker'),
          BottomNavigationBarItem(icon: Icon(Icons.rounded_corner_rounded), label: 'Profile')
        ],
      ),
    );
  }
}
