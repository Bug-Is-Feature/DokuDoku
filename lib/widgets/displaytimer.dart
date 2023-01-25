import 'package:flutter/material.dart';
import 'package:dokudoku/timeservice.dart';
import 'package:dokudoku/utils.dart';
import 'package:provider/provider.dart';

class DisplayTimer extends StatefulWidget {
  const DisplayTimer({super.key});

  @override
  State<DisplayTimer> createState() => _DisplayTimerState();
}

class _DisplayTimerState extends State<DisplayTimer> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerService>(context);

    return Column(
      children: [
        const SizedBox(
          height: 60,
        ),
        Text(
          provider.currentState == 'Focus'
              ? "${provider.iteration} Iteration"
              : "Break Time",
          style: textStyle(25, Colors.red, FontWeight.w700),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 4.2,
              height: 170,
              child: Center(
                child: Provider.of<TimerService>(context, listen: false)
                    .changeMinutesUnit(),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              ":",
              style: textStyle(60, Colors.brown, FontWeight.bold),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 4.2,
              height: 170,
              child: Center(
                child: Provider.of<TimerService>(context, listen: false)
                    .changeSecondsUnit(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
