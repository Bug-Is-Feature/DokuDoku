import 'dart:async';

import 'package:dokudoku/ui/components/custom_dialog_box.dart';
import 'package:flutter/material.dart';

class TimerService extends ChangeNotifier {
  int startTime = 0;
  int seconds = 0;
  int minutes = 0;
  int stopTime = 0;
  bool timerPlaying = false;
  String twoDigits(int n) => n.round().toString().padLeft(2, '0');
  Timer? timer;

  void start(BuildContext context) {
    timerPlaying = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (startTime == 7) {
        stop();
        fullTimeDialog(context);
        reset();
      } else {
        startTime++;
      }
      notifyListeners();
    });
  }

  void fullTimeDialog(BuildContext context) {
    String hr = changeHoursUnit(stopTime);
    String min = changeMinutesUnit(stopTime);
    String sec = changeSecondsUnit(stopTime);
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
    stopTime = startTime;
    notifyListeners();
  }

  void reset() {
    startTime = 0;
  }

  String changeSecondsUnit(int time) {
    seconds = startTime % 60;
    if (seconds == 0) {
      return "${seconds.round()}0";
    } else {
      return twoDigits(seconds);
    }
  }

  String changeMinutesUnit(int time) {
    minutes = time % 3600;
    if (minutes == 0) {
      return "${minutes.round()}0";
    } else {
      return twoDigits((minutes ~/ 60));
    }
  }

  String changeHoursUnit(int time) {
    return twoDigits((time ~/ 3600));
  }
}
