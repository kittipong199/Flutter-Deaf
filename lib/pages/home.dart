

import 'package:flutter/material.dart';

class HomaPage extends StatefulWidget {
  const HomaPage({super.key});

  @override
  State<HomaPage> createState() => _HomaPageState();
}

class _HomaPageState extends State<HomaPage> {
  int navindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFFFB200),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFB200),
        title: Text("หน้าแรก"),
        
      ),

      body: Center(
        child: Container(
          
          // btn เริ่มเรียน
          child: Column(
            mainAxisSize:MainAxisSize.min,
            children: [
             

              // image logo

              CircleAvatar(
                radius: 75,
                foregroundImage: AssetImage('assets/images/logo.jpg'),
              ),
              SizedBox(height: 20,),
              //  btn เริ่มเรียน 
              ElevatedButton(
                 style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF277BC0) ,
                shape: const StadiumBorder(),
                
                
                minimumSize: Size(120,50), // background
                
                // foreground
                  ),
                onPressed: () {},
                
               child: Text('เริ่มเรียน',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),))
              
              
               
            ],
           
          ),
          
       
        
        
        
      ),
        ),
      
      
    );
 
  }
  

}