
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:skateright_flutter/locations/skatelocation.dart';
import 'package:skateright_flutter/main_screen.dart';
import 'package:skateright_flutter/onboarding/onboarding_pg2.dart';
import 'package:skateright_flutter/pop_ups/create_spot_pop_up.dart';
import 'package:skateright_flutter/profile.dart';
import '../main.dart';



void main(){
  runApp(const onBoarding());
}
class onBoarding extends StatelessWidget{
  
  const onBoarding({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: const Color.fromRGBO(20, 20, 20, 1),
        child: Column(children:
      
         [
           const SizedBox(height: 120,width: 500,),
          
         Padding(
           padding: const EdgeInsets.only(right: 10,left:0,bottom: 0),
           
           child: Column(
             children:  [

               const SizedBox(width: 50),



                         SizedBox(
              width: 300,
              height: 300,
              child: Lottie.asset(
                'assets/animations/animation.json',
                
                animate: true,
                repeat: false,
              ),
            ),
    
    
               
               
               const SizedBox(height:30),
               const Text(
                    "Hey!!! Glad\nyou're here :)",
                    
                    style: 
                      TextStyle(
                      
                      color: Color.fromRGBO(241, 194, 0, 1),
                      fontFamily: 'RobotoMono',
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                      ),
                      
    
    
                       ),
    
                
                           ]),
                  
                        ),
         Row(
           children: const [
             SizedBox(width: 20),
             Padding(
               padding: EdgeInsets.only(top:30,left:20,),
               child: Text(             
                          "We want to get you on your\nskateboard and connect you\nwith your skating community. " ,
      
                          style: 
                                  TextStyle(
                                  
                                  color: Color.fromRGBO(240, 230, 208, 1),
                                  fontFamily: 'RobotoMono',
                                  fontSize: 19,
                                  fontWeight: FontWeight.normal
                                  ),
               ),
             ),
           ],
         ),
         
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row( 
            children: [
              const SizedBox(width: 100,),
                
                IconButton(
                  onPressed: null, 
                  icon:Image.asset(
                    'assets/images/selected_line.png'
                    
                    )),
    
    
                IconButton(
                  icon: Image.asset('assets/images/unselected_line.png')
                  , onPressed:null),
    
    
    
                IconButton(
                  icon: Image.asset('assets/images/unselected_line.png')
                  , onPressed:null),



                  Padding(
                  padding: const EdgeInsets.only(top:50,left: 80),
                  child: IconButton(
                    onPressed: 
                          (){
                            Navigator.of(context).pop(MaterialPageRoute(builder:(context)=> const onBoarding()));
                            
                            Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>  const onBoarding2()));
                          },
                   icon: Image.asset('assets/images/next_arrow.png')),
                )
   
              
            ],
            ),
        ),
         
        ]),
      ),
    );
  }
}
