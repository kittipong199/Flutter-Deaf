import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      
        //No  AppBar
        
       backgroundColor: Color(0xFFFFD218),
      

      //Body
      body: Container(
       
       child: Column(
        children: [

          Container(
            child: Row(
              children: [
                // Text sign in

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(child: Text("Sign in")),
                ),




                // Text sign up
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(child: Text("Sign Up")),
                ),



              ],
            ),
          )
        ],
       ),
      ),
     
    );
  }
}