import 'package:flutter/material.dart';
import 'package:grupp_5/views/intro_view/intro_view.dart';
import 'package:grupp_5/views/login_register_view/auth.dart';
import 'package:grupp_5/views/login_register_view/home_page.dart';
import 'package:grupp_5/views/login_register_view/login_register_view.dart';
import 'package:grupp_5/views/scramble_view/scramble_view.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const IntroView();
        } else {
          return LoginRegisterView();
        }
      },
    );
  }
}
