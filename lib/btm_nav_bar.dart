// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_field
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'nav_pages/fav.dart';
import 'nav_pages/home.dart';
// import 'nav_pages/user.dart';
import 'nav_pages/verify.dart';

class navbar extends StatefulWidget {
  const navbar({Key? key}) : super(key: key);

  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _navscreens = <Widget>[
    MyHomepage(),
    fav(),
    // user(),
    verify(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 20.0,
        ),
        child: GNav(
            textStyle: TextStyle(color: Colors.black),
            activeColor: Colors.amber,
            tabBackgroundColor: Colors.grey.shade400,
            padding: EdgeInsets.all(10.0),
            gap: 10.0,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.favorite_border,
                text: 'Fav',
              ),
              // GButton(
              //   icon: Icons.person,
              //   text: 'User',
              // ),
              GButton(
                icon: Icons.verified_user,
                // iconColor: Colors.green,
                iconActiveColor: Colors.green,
                text: 'Verify',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            }),
      ),
      body: _navscreens.elementAt(_selectedIndex),
    );
  }
}
