import 'package:dokudoku/ui/components/bottom_navbar.dart';
import 'package:dokudoku/ui/components/timer_mode_tabbar.dart';
import 'package:dokudoku/ui/view/stopwatch_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: TimerModeTabBar());
  }
}
