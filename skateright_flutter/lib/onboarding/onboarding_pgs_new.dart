import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skateright_flutter/main.dart';
import 'package:skateright_flutter/main_screen.dart';
import 'package:skateright_flutter/onboarding/onboarding_pg2.dart';

import 'onboarding.dart';
void main(){
  runApp(const onBoarding4());
}

MaterialPageRoute? nextPageRoute;

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({Key? key, required this.nextRoute}) : super(key: key);
  final MaterialPageRoute nextRoute;

  @override
  State<OnBoardPage> createState() => OnBoardPageState();
}

class OnBoardPageState extends State<OnBoardPage> {
  final List<Widget> _pages = [onBoarding2(),onBoarding4(),onBoarding2()];
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
class onBoarding4 extends StatelessWidget {
  const onBoarding4({Key? key}) : super(key: key);
 @override
  Widget build(BuildContext context) {
    
    
   return  Column(
         children:  [
           const SizedBox(height:30),
 
        SizedBox(
          height: 300,
          child:  Image.asset('assets/images/map_ratings.png')),
        
           const SizedBox(height: 30),

           const SizedBox(width: 50,),
           Image.asset('assets/images/arrow_green.png',scale: .8,),
           const Text(
             "Tap to add new spots on the map or",
             style: TextStyle(
               color: Color.fromRGBO(148, 179, 33, 1),
               fontFamily: 'RobotoMono',
               fontSize: 32,
               fontWeight: FontWeight.w700,
            ),
          ),
        const Text(
          "review/rate \nexisting spots.",
          style: TextStyle(
            color: Color.fromRGBO(235, 0, 26, 1),
            fontFamily: 'RobotoMono',
            fontSize: 32,
            fontWeight: FontWeight.w700,
        ),
          ),
        Image.asset('assets/images/arrow_red.png',scale:.8)
         

           
            
   
   
         ],
       );
  }
}
 
class onBoarding5 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(children: [
          const SizedBox(height: 40,),
          const SizedBox(width: 30,),
          Image.asset('assets/images/logocircle.png'),
          const SizedBox(height:40),
          SizedBox(width: 30,),
           Text(
                 "Create a profile\nand follow other \nskateboarders.",
                 style: TextStyle(
                   color: Color.fromRGBO(148, 179, 33, 1),
                   fontFamily: 'RobotoMono',
                   fontSize: 32,
                   fontWeight: FontWeight.w700,
             ),
           ),
          const SizedBox(height: 80),
          Image.asset('assets/images/profile_example.png',scale: 1.8)

        ]);
  }
}