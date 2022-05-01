


import 'package:flutter/material.dart';

void main(){
  runApp(const CreateSpotPopUp());
}

class CreateSpotPopUp extends StatelessWidget{
  const CreateSpotPopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width*.99,
        color: Colors.black,
        child: Column(
          children:  [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal:30,vertical: 10)
              
            ),
                
                Row(
                  children: <Widget> [
                    const SizedBox(width: 20,),
                    Image.asset('./assets/images/pin_location.png',fit: BoxFit.contain,scale: .7,width: 50,),
                    const Text(
                      ' Found a great spot?!\n Want to create a new spot?',
                        textAlign: TextAlign.left ,
                      style: TextStyle(
                        color: Color.fromRGBO(240, 230, 208, 1),
                        fontFamily: 'Karla-Regular',
                        fontSize: 18,
                        
                      
                      ),
                    ),
                ],),
                const SizedBox(height: 10),
                
                Row(
                  children: [
                    const SizedBox(width: 240),
                    TextButton(
                      
                      style: 
                       
                       
                         TextButton.styleFrom(backgroundColor: const Color(0x14212121),alignment: Alignment.bottomRight),
                        
                       
                        onPressed: (){},



          
                       child: 
                       const Text('Yeah!',
                            style:
                              TextStyle(
                                  color: Color(0xff94b321),
                                  fontSize: 21,
                                  fontFamily: "RobotoMono-Regular.ttf",
                                  fontWeight: FontWeight.w700,


                          ),
                       
                       
                       
                       ),
                      ),
                    TextButton(
                      
                      style: 
                       
                       
                         TextButton.styleFrom(backgroundColor: const Color(0x14212121),alignment: Alignment.bottomRight),
                        
                       
                        onPressed: (){},
                       child: 
                       const Text('Nahh',
                            style:
                              TextStyle(
                                  color: Color(0xffeb001b),
                                  fontSize: 21,
                                  fontFamily: "RobotoMono-Regular.ttf",
                                  fontWeight: FontWeight.w700,


                          ),
                       
                       
                       
                       ),
                      ),
                  ],
                ),

                   
                   
                 
                 
                 
                 ]),
                

                
            
              ),);
            

      
  }


  }





  



  void onPressed() {
   
  }


