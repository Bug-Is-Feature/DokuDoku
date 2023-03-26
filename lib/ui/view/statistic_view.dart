import 'package:dokudoku/model/sessions.dart';
import 'package:dokudoku/provider/session_provider.dart';
import 'package:dokudoku/services/timer_service.dart';
import 'package:dokudoku/ui/components/time_distribution_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticView extends StatefulWidget {
  const StatisticView({super.key});

  @override
  State<StatisticView> createState() => _StatisticViewState();
}

class _StatisticViewState extends State<StatisticView> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SessionProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: TimeDistributionChart(
                session: provider.session,
                sessionUpdateCallback: (Future<List<Session>> session) =>
                    setState(() => provider.session = session),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
