import 'package:dokudoku/model/sessions.dart';
import 'package:dokudoku/services/timer_service.dart';
import 'package:dokudoku/ui/components/time_distribution_chart.dart';
import 'package:flutter/material.dart';

class StatisticView extends StatefulWidget {
  const StatisticView({super.key});

  @override
  State<StatisticView> createState() => _StatisticViewState();
}

class _StatisticViewState extends State<StatisticView> {
  late Future<List<Session>> session = _getSession();

  Future<List<Session>> _getSession() async {
    List<Session> session = await TimerService.getTimerList();
    return session;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: TimeDistributionChart(
                session: session,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
