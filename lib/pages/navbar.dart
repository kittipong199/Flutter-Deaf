import 'package:app_deaf/pages/history.dart';
import 'package:app_deaf/pages/home.dart';
import 'package:app_deaf/pages/coures.dart';
import 'package:app_deaf/pages/proflie.dart';
import 'package:flutter/material.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({super.key});

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  int currentIndex = 0;  // กำหนดค่าเริ่มต้น สำหรับ navbar ในการแสดง wiggle หน้าแรก 0 คือ HomePage

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      body: IndexedStack(
        index: currentIndex,
        children: const [
          // สำหรับ แสดง หน้าต่างๆ
          HomaPage(),
          CouresPage(),
          HistoryPage(),
          ProfliePage(),
        ],
      ),
      // btn

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFFFFB200), // สีพื้นหลัง navbar
        selectedItemColor: Color.fromARGB(255, 0, 0, 0), // สีของ text
        unselectedItemColor: Colors.black87,
        iconSize: 40.0,// ขนาดicon
        selectedFontSize: 20, //-ขนาด ข้อความ
        // code for change wiggle in navbar
        currentIndex: currentIndex,
        onTap: ((value) {
          setState(() {
            currentIndex = value;
          });
        }),
        /////////////////////

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าแรก',
            // backgroundColor: Color(0xFFFFB200),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'หมวดหมู่',
            // backgroundColor: Color(0xFFFFB200),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'ประวัติ',
            // backgroundColor: Color(0xFFFFB200),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'โปรไฟล์',
            // backgroundColor: Color(0xFFFFB200),
          ),
        ],
      ),
    );
  }
}


