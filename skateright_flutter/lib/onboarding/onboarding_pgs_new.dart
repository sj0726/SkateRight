import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skateright_flutter/main.dart';
import 'package:skateright_flutter/main_screen.dart';
import 'package:skateright_flutter/onboarding/onboarding_pg2.dart';

import 'onboarding.dart';
void main(){
  runApp(onBoarding5());
}
class onBoarding4 extends StatelessWidget {
  const onBoarding4({Key? key}) : super(key: key);
 @override
  Widget build(BuildContext context) {
    
    
   return Material(
     child: Container(
       color: const Color.fromRGBO(20, 20, 20, 1),
       width: MediaQuery.of(context).size.width,
       child: Column(
         children:  [
       
           
             
           const SizedBox(height:70),
             FittedBox(

           fit: BoxFit.fitWidth,
           child: Image.asset('assets/images/map_ratings.png')),

           Row(
             children: [
               const SizedBox(width: 50,),
               FittedBox(


                 child: Image.asset('assets/images/arrow_green.png',scale: .8,),
               ),
             ],
           ),
           const Padding(
             padding: EdgeInsets.only(top:20,left:20,right:20),
              child: Text(
                "Tap to add new spots on the map or",
                style: TextStyle(
                  color: Color.fromRGBO(148, 179, 33, 1),
                  fontFamily: 'RobotoMono',
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Row(
          
          children: [
            const Padding(
             padding: EdgeInsets.only(left:20),
              child: Text(
                "review/rate \nexisting spots.",
                style: TextStyle(
                  color: Color.fromRGBO(235, 0, 26, 1),
                  fontFamily: 'RobotoMono',
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Image.asset('assets/images/arrow_red.png',scale:.8),






          ],




        )
         

           
            
   
   
         ],
       ),
   
     ),
   );
  }
}
 
class onBoarding5 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Column(children: [
          const SizedBox(height: 40,),
          Row(children: [
            const SizedBox(width: 30,),
            Image.asset('assets/images/logocircle.png'),
   
             




          ],),
          const SizedBox(height:40),
          Row(
            children: const [
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
            ],
          ),
          const SizedBox(height: 80),
          Image.asset('assets/images/profile_example.png',scale: 1.8)

        ]),
        
      
      ),

    );
   
  }



  
}