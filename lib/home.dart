import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metalfolding/profile.dart';
import 'mainpage.dart';
import 'search.dart';
import 'cart.dart';
import 'components/buttom_nav_bar.dart';
import 'shop.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //Navigate bottom bar
  int _selectedIndex = 0;
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //Pages to display
  final List<Widget> _pages = const [
    ShopPage(),
    SearchPage(),
    CartPage(),
    ProfilePage(),
  ];

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainPage()),
      (Route<dynamic> route) => false,
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          //Imply the back button on the leading side of the appbar
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF1E3F66),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () => signUserOut(),
            ),
          ],
      ),
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _pages[_selectedIndex],
    );
  }
}