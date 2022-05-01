import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skateright_flutter/main_screen.dart';
import 'package:skateright_flutter/onboarding/onboarding_pg2.dart';

import 'onboarding.dart';
void main(){
  runApp(const onBoarding3());
}
class onBoarding3 extends StatelessWidget {
  const onBoarding3({Key? key}) : super(key: key);

 

   @override
  Widget build(BuildContext context) {
    
    
   return Material(
     child: Container(
       color: const Color.fromRGBO(20, 20, 20, 1),
       width: MediaQuery.of(context).size.width,
       child: Column(
         children:  [
           
           
           Row(
             children: [
               Padding(
                 padding: const EdgeInsets.only(top:60,right:250,left:0),
                 child: 
                 Padding(
                   padding: const EdgeInsets.only(bottom:50),
                   child: Image.asset('assets/images/logocircle.png'),
                 ),
                 
                 
                 ),
                 IconButton(icon: Image.asset('assets/images/close_icon.png'), onPressed: () { Navigator.pop(context);
                              Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>  MainScreen()));
                            
                           },)
             ],
           ),
             const SizedBox(height: 30,),
              
              Row(
                children: [
                  const SizedBox(width: 120,),
                 Image.asset('assets/figures/skater1-white.png')
                  
                  





                ],



              ),
              const Padding(
                padding: EdgeInsets.only(top:150,left: 30,bottom: 30),
                child: Text("Get skating!\n Your way.",
                style: TextStyle(
                  color: Color.fromRGBO(241, 194, 0, 1),
                  fontFamily: 'RobotoMono',
                  fontSize: 33,
                  fontWeight: FontWeight.w700,
   
   
   
   
                ),
                
                ),
              ),
              
   
             
                
                
                
   
             Row( 
          children: [
            Padding(
                 padding:  const EdgeInsets.only(left:0,top:130),
                 child: IconButton(
                    onPressed: 
                    
                          (){
                            Navigator.pop(context);
                              Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>  onBoarding2()));
                            
                          
                          },
                   icon: Image.asset('assets/images/back_arrow.png')),
               ),
            const SizedBox(width: 80,),
              
              Padding(
                padding: const EdgeInsets.only(top:130),
                child: IconButton(
                  onPressed: null, 
                  icon:Image.asset(
                    'assets/images/unselected_line.png'
                    
                    )),
              ),
    
    
              Padding(
                padding:  const EdgeInsets.only(top:130),
                child: IconButton(
                  icon: Image.asset('assets/images/unselected_line.png')
                  , onPressed:null),
              ),
    
    
    
              Padding(
                padding: const EdgeInsets.only(top:130),
                child: IconButton(
                  icon: Image.asset('assets/images/selected_line.png')
                  , onPressed:null),
              ),


               
              
   
            
          ],
          ),
   
   
   
         ],
       ),
   
     ),
   );
  }
}
