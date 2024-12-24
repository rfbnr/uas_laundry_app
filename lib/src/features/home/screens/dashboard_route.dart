import 'package:flutter/material.dart';

import '../../transaction/screens/transaction_screen.dart';
import '../../profile/screens/profile_screen.dart';
import 'home_screen.dart';

class DashboardRoute extends StatefulWidget {
  const DashboardRoute({super.key});

  @override
  State<DashboardRoute> createState() => _DashboardRouteState();
}

class _DashboardRouteState extends State<DashboardRoute> {
  int currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    TransactionScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        elevation: 10,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
