
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skateright_flutter/onboarding/onboarding_pg3.dart';

import 'onboarding.dart';

class onBoarding2 extends StatelessWidget {
  const onBoarding2({Key? key}) : super(key: key);

 

   @override
  Widget build(BuildContext context) {
    
    
   return Material(
     child: Container(
       color: const Color.fromRGBO(20, 20, 20, 1),
       width: MediaQuery.of(context).size.width,
       child: Column(
         children:  [
           
           Padding(
             padding: const EdgeInsets.only(top:60,right:250,left:0),
             child: 
             Image.asset('assets/images/logocircle.png'),
   
             
             
             
             
             ),
             
              const Padding(
                padding: EdgeInsets.only(top:50,left: 50),
                child: Text("1. Find the best skate spots for you\n\n2. Add new spots or rate/review existing spots\n\n3. follow other skateboarders",
                style: TextStyle(
                  color: Color.fromRGBO(148, 179, 33, 1),
                  fontFamily: 'RobotoMono',
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
   
   
   
   
                ),
                
                ),
              ),
   
             
   
                 
   
              
             Padding(
               padding: const EdgeInsets.only(top:100),
               child: Row( 
              children: [
                Padding(
                 padding:  const EdgeInsets.only(left:0,top:100),
                 child: IconButton(
                    onPressed: 
                    
                          (){
                            Navigator.pop(context);
                              Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>  onBoarding()));
                            
                          
                          },
                   icon: Image.asset('assets/images/back_arrow.png')),
               ),
            const SizedBox(width: 70,),
                
                IconButton(
                  onPressed: null, 
                  icon:Image.asset(
                    'assets/images/unselected_line.png'
                    
                    )),
    
    
                IconButton(
                  icon: Image.asset('assets/images/selected_line.png')
                  , onPressed:null),
    
    
    
                IconButton(
                  icon: Image.asset('assets/images/unselected_line.png')
                  , onPressed:null),



                  Padding(
                  padding: const EdgeInsets.only(top:100,left: 80),
                  child: IconButton(
                    onPressed: 
                          (){
                            Navigator.of(context).pop(MaterialPageRoute(builder:(context)=> const onBoarding()));
                            
                            Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>  const onBoarding3()));
                          },
                   icon: Image.asset('assets/images/next_arrow.png')),
                )
   
            
          ],
          ),
             ),
   
   
   
         ],
       ),
   
     ),
   );
  }
}
