import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "./cookie_clicker.dart";
import 'package:skateright_flutter/profile/profile_page.dart';
import 'map/map_page.dart';
import 'package:firebase_core/firebase_core.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.markerIcon, required this.mapStyle})
      : super(key: key);
  final BitmapDescriptor markerIcon;
  final String mapStyle;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Future<FirebaseApp> _future = Firebase.initializeApp();
  late List<Widget> pageList;

  @override
  void initState() {
    super.initState();
    pageList = <Widget>[
      MapScreen(
        key: PageStorageKey('Map'),
        customMarker: widget.markerIcon,
        mapStyle: widget.mapStyle,
      ),
      ProfilePage(),
      // ClickerPage(key: PageStorageKey('Clicker')),
    ];
  }

  int _pageIndex = 0;

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
