import 'package:flutter/material.dart';

import 'package:car_pool_app/Screens/routes_screen.dart';
import 'package:car_pool_app/Screens/history_screen.dart';
import 'package:car_pool_app/Screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const routeName = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late int _selectedNavIndex;

  Widget screenSelector() {
    final List<Widget> screens = [const RoutesScreen(), const HistoryScreen(), const ProfileScreen()];
    return screens[_selectedNavIndex];
  }

  @override
  void initState() {
    _selectedNavIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedNavIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedItemColor: const Color(0xFF1CD416),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (int index) {
          setState(() {
            _selectedNavIndex = index;
          });
        },
      ),

      body: screenSelector(),
    );
  }
}