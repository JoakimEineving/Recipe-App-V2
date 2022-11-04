import 'package:flutter/material.dart';
import 'package:grupp_5/views/login_register_view/home_page.dart';
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
    return Container(
      height: 75,
      child: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() {
          print(i);
          currentIndex = i;
          if (currentIndex == 0) {
            Navigator.of(context).pushNamed(homePageRoute);
          } else if (currentIndex == 1) {
            Navigator.of(context).pushNamed(scrambleViewRoute);
          } else if (currentIndex == 2) {
            Navigator.of(context).pushNamed(scrambleViewRoute);
          }
        }),
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Example"),
            selectedColor: Colors.purple,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text("Example"),
            selectedColor: Colors.pink,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.search),
            title: Text("Example"),
            selectedColor: Colors.orange,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Example"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
