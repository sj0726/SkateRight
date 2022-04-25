import 'package:flutter/material.dart';
import 'package:skateright_flutter/main_screen.dart';
import 'package:skateright_flutter/styles/skate_theme.dart';

void main(){
  runApp(const CreateSpotPrompt());
}

class CreateSpotPrompt extends StatelessWidget{
  const  CreateSpotPrompt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width*.99,
        color: Colors.black,
        child: Column(
          children:  const
           [
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:20,vertical: 10),
              
            
            child: Text(
                      'Awesome! Enter a name and fill out the other information below.',
                        textAlign: TextAlign.left ,
                      style: TextStyle(
                        color: Color.fromRGBO(240, 230, 208, 1),
                        fontFamily: 'Karla-Regular',
                        fontSize: 18,
                        
                      
                      ),
                    )
                    ),
          ])));
  }
  }





  

