import 'package:dokudoku/services/timer_service.dart';
import 'package:dokudoku/ui/components/button.dart';
import 'package:dokudoku/ui/components/custom_dialog_box.dart';
import 'package:dokudoku/ui/components/stopwatch_timer.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:provider/provider.dart';

class StopwatchView extends StatelessWidget {
  const StopwatchView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerService>(context);
    return Scaffold(
      backgroundColor: context.resources.color.colorLightest,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                StopwatchTimer(),
                SizedBox(
                  height: 70,
                ),
                Button(
                  child: provider.timerPlaying ? Text('Stop') : Text('Start'),
                  backgroundColor: provider.timerPlaying
                      ? context.resources.color.colorDarkest
                      : context.resources.color.colorDark,

                  // provider.timerPlaying ? Text('Stop') : Text('Start'),
                  // backgroundColor: context.resources.color.warning,
                  onPressed: () {
                    if (provider.timerPlaying) {
                      Provider.of<TimerService>(context, listen: false).stop();
                      showDialog(
                        context: context,
                        builder: (context) => CustomDialog(
                          title: "Reading result",
                          description: provider.stopTime > 5
                              ? (provider.stopTime <= 10
                                  ? '${provider.stopTime.round().toString()} sec (saved)'
                                  : '${provider.stopTime.round().toString()} min (saved)')
                              : 'result not saved (less than 5 minutes)',
                          buttonText: "View Stat",
                          buttonText2: 'Close',
                          onPressed2: () {
                            Navigator.pop(context);
                          },
                          onPressed: () {},
                        ),
                      );
                      Provider.of<TimerService>(context, listen: false).reset();
                    } else {
                      Provider.of<TimerService>(context, listen: false).start();
                    }
                  },
                  size: Size(99, 44),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
