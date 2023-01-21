import 'package:dokudoku/services/timer_service.dart';
import 'package:dokudoku/ui/components/timer_display.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:provider/provider.dart';

class StopwatchTimer extends StatelessWidget {
  const StopwatchTimer({super.key});

  @override
  Widget build(BuildContext context) {
    int min = 5;
    int maxMin = 60;
    final provider = Provider.of<TimerService>(context);
    return SizedBox(
      width: 250,
      height: 250,
      child: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: provider.startTime / (maxMin * 60 * 2),
              strokeWidth: 9,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation(context.resources.color.blue),
            ),
            Center(child: DisplayTimer()),
          ],
        ),
      ),
    );
  }
}
