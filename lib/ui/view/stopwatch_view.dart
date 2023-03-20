import 'dart:convert';

import 'package:dokudoku/services/auth_service.dart';
import 'package:dokudoku/provider/timer_provider.dart';
import 'package:dokudoku/services/timer_service.dart';
import 'package:dokudoku/ui/components/button.dart';
import 'package:dokudoku/ui/components/custom_dialog_box.dart';
import 'package:dokudoku/ui/components/stopwatch_timer.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:provider/provider.dart';

class StopwatchView extends StatefulWidget {
  final int id;
  final String title;
  const StopwatchView({super.key, required this.id, required this.title});

  @override
  State<StopwatchView> createState() => _StopwatchViewState();
}

class _StopwatchViewState extends State<StopwatchView> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerProvider>(context);
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: context.resources.color.colorWhite.withOpacity(0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.title.replaceAll('%2520', ' '),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Button(
                backgroundColor: provider.timerPlaying
                    ? context.resources.color.colorDarkest
                    : context.resources.color.colorDark,
                onPressed: () async {
                  if (provider.timerPlaying) {
                    Provider.of<TimerProvider>(context, listen: false).stop();
                    if (provider.totalDuration >= 5) {
                      await TimerService.saveTimer(
                        context,
                        widget.id,
                        provider.totalDuration,
                      );
                    }
                    if (!mounted) return;
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => CustomDialog(
                        title: provider.totalDuration >= 5
                            ? "Reading result"
                            : '/ᐠ｡_｡ᐟ\\',
                        description: provider.totalDuration >= 5
                            ? Provider.of<TimerProvider>(context, listen: false)
                                .formattedTotalDuration(provider.totalDuration)
                            : 'You can do it better next time',
                        buttonText: "View Stat",
                        buttonText2: 'Close',
                        onPressed2: () {
                          provider.currentMode = TimerMode.none;
                          Navigator.pop(context);
                        },
                        onPressed: () {},
                      ),
                    );
                    Provider.of<TimerProvider>(context, listen: false).reset();
                  } else {
                    Provider.of<TimerProvider>(context, listen: false)
                        .start(context);
                  }
                },
                size: const Size(99, 44),
                child: provider.timerPlaying
                    ? const Text('Stop')
                    : const Text('Start'),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              if (provider.timerPlaying == false) ...[
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                      child: Column(
                        children: const [
                          Text(
                            'The maximum for Stopwatch is 2 hours.\nYou need to read for at least 5 minutes to record your history.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
