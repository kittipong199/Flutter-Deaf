

 import 'package:app_deaf/pages/home.dart';
 import 'package:app_deaf/pages/coures.dart';
 import 'package:flutter/material.dart';

 class NavbarPage extends StatefulWidget {
   const NavbarPage({super.key});

   @override
   State<NavbarPage> createState() => _NavbarPageState();
 }

 class _NavbarPageState extends State<NavbarPage> {
   int _selectedIndex = 0;

   
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: IndexedStack(
         index: _selectedIndex,
         children: [
           HomaPage(),
          
           CouresPage(),
         ],
       ),
       // btn  
      
     
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color(0xFFFFB200),
            
          ),
          BottomNavigationBarItem(
            
            icon: Icon(Icons.book),
            label: 'Coures',
            
            backgroundColor: Color(0xFFFFB200),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: 'History',
            backgroundColor: Color(0xFFFFB200),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Profile',
            backgroundColor: Color(0xFFFFB200),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 0, 0, 0),
        
      ),
     );
   }
 }

// IndexedStack(
//          index: navindex,
//          children: [
//            HomaPage(),
          
//            CouresPage(),
//          ],
//        ),
//        bottomNavigationBar: NavigationBar(
//            selectedIndex: navindex,
//            onDestinationSelected: (value) {
//              setState(() {
//                // วาดน่าจอใหม่
//                navindex = value;
//              });
//            },
//            destinations: [
//              NavigationDestination(icon: Icon(Icons.home), label: "Home"),
//              NavigationDestination(icon: Icon(Icons.book), label: "Coures"),
//              NavigationDestination(icon: Icon(Icons.play_arrow), label: "MyCourse"),
                
//              NavigationDestination(icon: Icon(Icons.people), label: "Profile"),
//            ]),
//      );