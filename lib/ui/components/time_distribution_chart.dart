import 'package:dokudoku/model/sessions.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class TimeDistributionChart extends StatefulWidget {
  Future<List<Session>> session;
  final void Function(Future<List<Session>>) sessionUpdateCallback;

  TimeDistributionChart({
    super.key,
    required this.session,
    required this.sessionUpdateCallback,
  });

  @override
  State<TimeDistributionChart> createState() => _TimeDistributionChartState();
}

class _TimeDistributionChartState extends State<TimeDistributionChart> {
  TooltipBehavior? _tooltipBehavior;
  List<String> tempTimeStamp = [];

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        width: 350,
        child: FutureBuilder<List<Session>>(
          future: widget.session,
          builder:
              (BuildContext context, AsyncSnapshot<List<Session>> snapshot) {
            late List<String> timeStamp = snapshot.data!
                .map((e) => DateFormat.Hm().format(DateTime.parse(e.createdAt)))
                .toList();
            late List<int> duration =
                snapshot.data!.map((e) => e.duration).toList();
            late int totalDuration =
                snapshot.data!.map((e) => e.duration).reduce((a, b) => a + b);
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    title: ChartTitle(
                      text: 'Time Distribution $totalDuration',
                      textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                          fontFamily: 'primary'),
                    ),
                    tooltipBehavior: _tooltipBehavior,
                    series: <ColumnSeries<SessionData, String>>[
                      ColumnSeries<SessionData, String>(
                        dataSource: <SessionData>[
                          for (int i = 0; i < snapshot.data!.length; i++)
                            SessionData(
                              timeStamp[i],
                              duration[i],
                            ),
                        ],
                        xValueMapper: (SessionData x, _) => x.time,
                        yValueMapper: (SessionData y, _) => y.duration,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}

class SessionData {
  SessionData(this.time, this.duration);
  final String time;
  final int duration;
}
