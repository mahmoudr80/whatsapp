import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whats_app/feaures/Calls/ui/calls_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex = 0;

  final List<Widget> screens = [
    Center(child: Text("Status Screen")),
    CallsScreen(),
    Center(child: Text("Camera Screen")),
    Center(child: Text("Chats Screen")),
    Center(child: Text("Settings Screen")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex], 

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/status.svg", width: 26, height: 26),
            label: "status",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/calls.svg", width: 26, height: 26),
            label: "calls",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/camera.svg", width: 26, height: 26),
            label: "camera",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/chats.svg", width: 26, height: 26),
            label: "chat",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/setting.svg", width: 26, height: 26),
            label: "setting",
          ),
        ],
      ),
    );
  }
}