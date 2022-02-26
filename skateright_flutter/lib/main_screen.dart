import 'package:flutter/material.dart';
import "./map_page.dart";
import "./cookie_clicker.dart";
// import 'package:quotes_app/home.dart';
// import 'package:quotes_app/characters_page.dart';
// import 'package:quotes_app/favorites.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  int _pageIndex = 0;
  List<Widget> pageList = <Widget>[
    MapPage(),
    ClickerPage()
  ];

  void _onNavigationTap(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageIndex,
        selectedItemColor: Colors.purple[600],
        onTap: _onNavigationTap,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Spots'),
          BottomNavigationBarItem(
              icon: Icon(Icons.cookie), label: 'Clicker'),

        ],
      ),
    );
  }
}
