import 'package:flutter/material.dart';
import 'package:grupp_5/components/providers/provider.dart';
import 'package:grupp_5/views/login_register_view/home_page.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:grupp_5/constants/routes.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
      builder: (context, provider, child) => SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
          if (index == 0) {
            Navigator.pushNamed(context, scrambleViewRoute);
          } else if (index == 1) {
            Navigator.pushNamed(context, scrambleViewRoute);
          } else if (index == 2) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                scrambleViewRoute, (Route<dynamic> route) => false);
          }
        }),
        items: [
          /// Home
          // SalomonBottomBarItem(
          //   icon: const Icon(Icons.home),
          //   title: const Text('Home'),
          //   selectedColor: Colors.purple,
          // ),

          // /// Likes
          // SalomonBottomBarItem(
          //   icon: const Icon(Icons.favorite_border),
          //   title: const Text('Likes'),
          //   selectedColor: Colors.pink,
          // ),

          // /// Search
          // SalomonBottomBarItem(
          //   icon: const Icon(Icons.search),
          //   title: const Text('Search'),
          //   selectedColor: Colors.orange,
          // ),

          // /// Profile
          // SalomonBottomBarItem(
          //   icon: const Icon(Icons.person_outline),
          //   title: const Text('Profile'),
          //   selectedColor: Colors.teal,
          // ),
        ],
      ),
    );
  }
}
