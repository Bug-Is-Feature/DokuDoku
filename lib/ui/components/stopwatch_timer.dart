import 'package:dokudoku/provider/timer_provider.dart';
import 'package:dokudoku/ui/components/timer_display.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:provider/provider.dart';

class StopwatchTimer extends StatelessWidget {
  const StopwatchTimer({super.key});

  @override
  Widget build(BuildContext context) {
    int maxMin = 120;
    final provider = Provider.of<TimerProvider>(context);
    return SizedBox(
      width: 250,
      height: 250,
      child: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: provider.currentDuration / (maxMin * 60),
              strokeWidth: 9,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation(context.resources.color.blue),
            ),
            const Center(child: DisplayTimer()),
          ],
        ),
      ),
    );
  }
}
