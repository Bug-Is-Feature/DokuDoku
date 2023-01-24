import 'dart:async';

import 'package:dokudoku/ui/components/custom_dialog_box.dart';
import 'package:flutter/material.dart';

class TimerService extends ChangeNotifier {
  int currentDuration = 0;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  int totalDuration = 0;
  bool timerPlaying = false;
  String twoDigits(int n) => n.round().toString().padLeft(2, '0');
  Timer? timer;

  void start(BuildContext context) {
    timerPlaying = true;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (currentDuration == 7200) {
          stop();
          maxTimeDialog(context);
          reset();
        } else {
          currentDuration++;
        }
        notifyListeners();
      },
    );
  }

  void maxTimeDialog(BuildContext context) {
    String hr = formattedHours(totalDuration);
    String min = formattedMinutes(totalDuration);
    String sec = formattedSeconds(totalDuration);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CustomDialog(
        title: 'Complete',
        description: "$hr h: $min m: $sec s",
        buttonText: "View Stat",
        buttonText2: 'Close',
        onPressed2: () {
          Navigator.pop(context);
        },
        onPressed: () {},
      ),
    );
  }

  void stop() {
    timer!.cancel();
    timerPlaying = false;
    totalDuration = currentDuration;
    notifyListeners();
  }

  void reset() {
    currentDuration = 0;
  }

  String formattedSeconds(int time) {
    seconds = time % 60;
    return twoDigits(seconds);
  }

  String formattedMinutes(int time) {
    minutes = (time % 3600) ~/ 60;
    return twoDigits(minutes);
  }

  String formattedHours(int time) {
    hours = time ~/ 3600;
    return twoDigits(hours);
  }
}
