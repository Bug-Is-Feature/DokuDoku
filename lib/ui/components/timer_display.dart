import 'package:dokudoku/provider/timer_provider.dart';
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
    final provider = Provider.of<TimerProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 170,
              child: Center(
                child: Text(
                  Provider.of<TimerProvider>(context, listen: false)
                      .formattedHours(provider.currentDuration),
                  style: TextStyle(
                    fontSize: 60,
                    color: context.resources.color.colorDarkest,
                    fontFamily: 'primary',
                  ),
                ),
              ),
            ),
            const SizedBox(
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
            const SizedBox(
              width: 2,
            ),
            SizedBox(
              height: 170,
              child: Center(
                child: Text(
                  Provider.of<TimerProvider>(context, listen: false)
                      .formattedMinutes(provider.currentDuration),
                  style: TextStyle(
                    fontSize: 60,
                    color: context.resources.color.colorDarkest,
                    fontFamily: 'primary',
                  ),
                ),
              ),
            ),
            const SizedBox(
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
            const SizedBox(
              width: 2,
            ),
            SizedBox(
              height: 170,
              child: Center(
                child: Text(
                  Provider.of<TimerProvider>(context, listen: false)
                      .formattedSeconds(provider.currentDuration),
                  style: TextStyle(
                    fontSize: 60,
                    color: context.resources.color.colorDarkest,
                    fontFamily: 'primary',
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
