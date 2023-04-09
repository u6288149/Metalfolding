import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  final Function(int)? onTabChange;
  const MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10),
      child: GNav(
        padding: const EdgeInsets.all(20),
        color: const Color(0xFF528AAE),
        activeColor: Colors.white,
        tabBackgroundColor: const Color(0xFF528AAE),
        // tabActiveBorder: Border.all(color: Colors.brown.shade100),
        tabBorderRadius: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        gap: 8,
        onTabChange: (value) => onTabChange!(value),
        tabs: const [
          GButton(
            icon: Icons.shop,
            text: 'Shop',
          ),
          GButton(
            icon: Icons.search,
            text: 'Search',
          ),
          GButton(
            icon: Icons.shopping_bag,
            text: 'Cart',
          ),
          GButton(
            icon: Icons.account_circle,
            text: 'Profile',
          ),
        ],
      ),
    );
  }
}
