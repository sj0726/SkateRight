import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          child: IconButton(
            icon: const Text(
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
      ],
    );
  }
}