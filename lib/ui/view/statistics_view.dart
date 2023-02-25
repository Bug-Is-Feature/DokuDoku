import 'package:dokudoku/ui/components/tabbar_filter_statistic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class StatisticsView extends StatefulWidget {
  const StatisticsView({super.key});

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarFilterStatistic(),
    );
  }
}
