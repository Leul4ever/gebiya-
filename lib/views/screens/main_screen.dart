import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     bottomNavigationBar: BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon:Image.asset('assets/images/icons/store_1.png'),label: 'Home'),
        BottomNavigationBarItem(icon:Image.asset('assets/images/icons/store_1.png'),label: 'Home'),
      ],
     ), 
    );
  }
}