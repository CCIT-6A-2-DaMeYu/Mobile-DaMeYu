import 'package:dameyu_project/data/image_icon/navbar_imageicon.dart';
import 'package:dameyu_project/screen/home/home_screen.dart';
import 'package:dameyu_project/screen/profile/profile_screen.dart';
import 'package:dameyu_project/screen/result_predict/result_predict_screen.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List halaman = [
    const HomeScreen(),
    const ResultPredictScreen(),
    const ProfileScreen()
    
  ];

  int selectedIndex = 0;

  void selectPage(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFFFEDF1),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(NavBarImageIcon.home_NavbarIcon),
            ),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(NavBarImageIcon.result_NavbarIcon),
            ),
            label: 'Result',
          ),

          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(NavBarImageIcon.profile_NavbarIcon)
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedIndex,
        // selectedIconTheme: IconThemeData(color: Color(0xff448E75)),
        selectedItemColor: const Color(0xffEB6383),
        type: BottomNavigationBarType.fixed,
        onTap: selectPage,
      ),
      body: halaman.elementAt(selectedIndex),
    );
  }
}