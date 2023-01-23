import 'package:dokudoku/services/timer_service.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 170,
              child: Center(
                child: Provider.of<TimerService>(context, listen: false)
                    .changeHoursUnit(context),
              ),
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              ":",
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: context.resources.color.colorDarkest,
              ),
            ),
            SizedBox(
              width: 2,
            ),
            Container(
              height: 170,
              child: Center(
                child: Provider.of<TimerService>(context, listen: false)
                    .changeMinutesUnit(context),
              ),
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              ":",
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: context.resources.color.colorDarkest,
              ),
            ),
            SizedBox(
              width: 2,
            ),
            Container(
              height: 170,
              child: Center(
                child: Provider.of<TimerService>(context, listen: false)
                    .changeSecondsUnit(context),
              ),
            ),
          ],
        )
      ],
    );
  }
}
