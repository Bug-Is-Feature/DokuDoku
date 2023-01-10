import 'package:dokudoku/ui/components/bottom_navbar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
          child: Text('Home'),
        ),
        bottomNavigationBar: BottomNavBar());
  }
}
