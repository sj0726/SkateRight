import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1250));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Center(
        child: Lottie.asset(
          'assets/animations/loading_skaters.json',
          controller: _controller,
          height: MediaQuery.of(context).size.height * 0.2,
          animate: true,
          onLoaded: (composition) {
            _controller!
              ..duration = composition.duration
              ..forward();
            // _controller!.repeat();
          },
        ),
      ),
    );
  }
}


// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key = const Key('splash')}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Theme.of(context).backgroundColor,
//       child: Center(

//         child: Icon(Icons.skateboarding_outlined,
//             color: Theme.of(context).accentColor, size: 72),
//       ),
//     );
//   }
// }
