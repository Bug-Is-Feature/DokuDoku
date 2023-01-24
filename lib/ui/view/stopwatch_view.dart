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
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              const StopwatchTimer(),
              const SizedBox(
                height: 70,
              ),
              Button(
                backgroundColor: provider.timerPlaying
                    ? context.resources.color.colorDarkest
                    : context.resources.color.colorDark,
                onPressed: () {
                  if (provider.timerPlaying) {
                    Provider.of<TimerService>(context, listen: false).stop();
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => CustomDialog(
                        title: provider.totalDuration >= 300
                            ? "Reading result"
                            : '/ᐠ｡_｡ᐟ\\',
                        description: provider.totalDuration >= 300
                            ? Provider.of<TimerService>(context, listen: false)
                                .formattedTotalDuration()
                            : 'You can do it better next time',
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
                    Provider.of<TimerService>(context, listen: false)
                        .start(context);
                  }
                },
                size: const Size(99, 44),
                child: provider.timerPlaying
                    ? const Text('Stop')
                    : const Text('Start'),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.09),
              Column(
                children: [
                  if (provider.timerPlaying == false) ...[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: const [
                          Text(
                            'The maximum for Stopwatch is 2 hours,',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            'You need to read for at least 5 minutes to record your history.',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ]
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
