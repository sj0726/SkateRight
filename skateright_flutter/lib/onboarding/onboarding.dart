import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

MaterialPageRoute? nextPageRoute;

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({Key? key, required this.nextRoute}) : super(key: key);
  final MaterialPageRoute nextRoute;

  @override
  State<OnBoardPage> createState() => OnBoardPageState();
}

class OnBoardPageState extends State<OnBoardPage> {
  final List<Widget> _pages = [_Page1(), _Page2(), _Page3()];
  int _index = 0;
  PageController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.95);
    nextPageRoute = widget.nextRoute;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: PageView.builder(
        itemCount: 3,
        controller: _controller,
        onPageChanged: (index) => setState(() => _index = index),
        itemBuilder: (context, i) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 70, bottom: 20, left: 20, right: 20),
            child: _pages[i],
          );
        },
      ),
    );
  }
}

class _Page1 extends StatelessWidget {
  const _Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 300,
          child: Lottie.asset(
            'assets/animations/onboarding.json',
            animate: true,
            repeat: false,
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          "Hey!!! Glad\nyou're here :)",
          style: TextStyle(
              color: Color.fromRGBO(241, 194, 0, 1),
              fontFamily: 'RobotoMono',
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 35),
        const Text(
          "We want to get you on your skateboard and connect you with your skating community",
          style: TextStyle(
            color: Color.fromRGBO(240, 230, 208, 1),
            fontFamily: 'RobotoMono',
            fontSize: 19,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class _Page2 extends StatelessWidget {
  const _Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Image.asset('assets/logo/logoCircle.png'),
        const Align(
          alignment: Alignment.center,
          child: Text(
            "1. Find the best skate spots for you\n\n2. Add new spots or rate/review existing spots\n\n3. follow other skateboarders",
            style: TextStyle(
              color: Color.fromRGBO(148, 179, 33, 1),
              fontFamily: 'RobotoMono',
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _Page3 extends StatelessWidget {
  const _Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
              Theme.of(context).primaryColorLight, BlendMode.srcATop),
          child: Image.asset('assets/figures/skater1.png'),
        ),
        Align(
          alignment: Alignment.center,
          child: TextButton(
            child: const Text(
              "Get skating\n your way!",
              style: TextStyle(
                color: Color.fromRGBO(241, 194, 0, 1),
                fontFamily: 'RobotoMono',
                fontSize: 33,
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: () => Navigator.of(context).pushReplacement(nextPageRoute!),
          ),
        ),

        Padding(padding: EdgeInsets.only(bottom: 15,), child:
        Align(
          alignment: Alignment.bottomRight,
          child: 
          ElevatedButton(
            child: Text("Go!", style: Theme.of(context).textTheme.headline2!.copyWith(color: Theme.of(context).backgroundColor),),
            onPressed: () => Navigator.of(context).pushReplacement(nextPageRoute!),
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) => Theme.of(context).secondaryHeaderColor),
              fixedSize:
          MaterialStateProperty.resolveWith((states) => const Size(120, 38)),              
            ),
          )
        )
        )
      ],
    );
  }
}
