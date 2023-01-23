import 'package:dokudoku/ui/components/timer_mode_tabbar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: TimerModeTabBar());
  }
}
