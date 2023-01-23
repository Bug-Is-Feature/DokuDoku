import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class TimerService extends ChangeNotifier {
  int startTime = 0;
  int seconds = 0;
  int minutes = 0;
  int stopTime = 0;
  bool timerPlaying = false;
  String twoDigits(int n) => n.round().toString().padLeft(2, '0');
  Timer? timer;

  void start() {
    timerPlaying = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      startTime++;
      upperBound();
      notifyListeners();
    });
  }

  void stop() {
    timer!.cancel();
    timerPlaying = false;
    print(startTime);
    stopTime = startTime;
    notifyListeners();
  }

  void reset() {
    startTime = 0;
  }

  void upperBound() {
    if (startTime == 7200) {
      stop();
      reset();
    }
  }

  Widget? changeSecondsUnit(BuildContext context) {
    seconds = startTime % 60;

    if (seconds == 0) {
      return Text(
        "${seconds.round()}0",
        style: TextStyle(
            fontSize: 60,
            color: context.resources.color.colorDarkest,
            fontFamily: 'primary'),
      );
    } else {
      return Text(
        twoDigits(seconds),
        style: TextStyle(
            fontSize: 60,
            color: context.resources.color.colorDarkest,
            fontFamily: 'primary'),
      );
    }
  }

  Widget? changeMinutesUnit(BuildContext context) {
    minutes = startTime % 3600;

    if (minutes == 0) {
      return Text(
        "${minutes.round()}0",
        style: TextStyle(
            fontSize: 60,
            color: context.resources.color.colorDarkest,
            fontFamily: 'primary'),
      );
    } else {
      return Text(
        twoDigits((minutes ~/ 60)),
        style: TextStyle(
            fontSize: 60,
            color: context.resources.color.colorDarkest,
            fontFamily: 'primary'),
      );
    }
  }

  Widget? changeHoursUnit(BuildContext context) {
    return Text(
      twoDigits((startTime ~/ 3600)),
      style: TextStyle(
          fontSize: 60,
          color: context.resources.color.colorDarkest,
          fontFamily: 'primary'),
    );
  }
}
