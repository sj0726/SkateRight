import 'package:flutter/material.dart';

import 'main_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late final Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();

//     _controller =
//         AnimationController(vsync: this, duration: const  Duration(seconds: 1));
//     _animation = Tween(begin: 0.0, end: 1.0,).animate(_controller);
//     // _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Theme.of(context).backgroundColor,
//       child: Center(
//         // child: FadeTransition(
//           // opacity: _animation,
//           child:
//           Icon(Icons.skateboarding_outlined,
//               color: Theme.of(context).accentColor, size: 72),
//         ),
//     );
//   }
// }

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key = const Key('splash')}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Center(
        // child: FadeTransition(
        // opacity: _animation,
        child: Icon(Icons.skateboarding_outlined,
            color: Theme.of(context).accentColor, size: 72),
      ),
    );
  }
}
