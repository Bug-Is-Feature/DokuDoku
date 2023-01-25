import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dokudoku/utils.dart';

class TimerService extends ChangeNotifier {
  final sessionDurationController = TextEditingController();
  final sessionNumberController = TextEditingController();
  final breakTimeController = TextEditingController();

  int enteredSessionDuration = 0;
  int enteredSessionNumberDuration = 0;
  int enteredBreakTime = 0;

  Timer? timer;
  int currentDuration = 0;
  int seconds = 0;
  int minutes = 0;
  bool timerPlaying = false;
  int iteration = 1;
  String currentState = "Focus";
  String twoDigits(int n) => n.round().toString().padLeft(2, '0');

  void submitData() {
    enteredSessionDuration = int.parse(sessionDurationController.text);
    enteredSessionNumberDuration = int.parse(sessionNumberController.text);
    enteredBreakTime = int.parse(breakTimeController.text);

    if (enteredSessionDuration <= 0 ||
        enteredSessionNumberDuration <= 0 ||
        enteredBreakTime <= 0) {
      print('Error');
    }

    if (currentState == 'Cancel') {
      iteration = 1;
      currentState = 'Focus';
      currentDuration = 0;
      currentDuration = enteredSessionDuration;
      start();
    } else {
      currentDuration = enteredSessionDuration;
      start();
    }

    print(enteredSessionDuration);
    print(enteredSessionNumberDuration);
    print(enteredBreakTime);
    notifyListeners();
  }

  void start() {
    timerPlaying = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentDuration == 0) {
        handleNextIteration();
      } else {
        currentDuration--;
        notifyListeners();
      }
    });
  }

  void stop() {
    timer!.cancel();
    timerPlaying = false;
    notifyListeners();
  }

  void cancelSession() {
    timer!.cancel();
    timerPlaying = false;
    currentState = 'Cancel';
    notifyListeners();
  }

  void handleNextIteration() {
    if (currentState == "Focus") {
      if (iteration < enteredSessionNumberDuration) {
        currentState = "Break Time";
        currentDuration = enteredBreakTime;
        iteration++;
      } else if (iteration >= enteredSessionNumberDuration) {
        print('eiei');
        stop();
      }
    } else if (currentState == "Break Time") {
      currentState = "Focus";
      currentDuration = enteredSessionDuration;
    }
    notifyListeners();
  }

  Widget? changeSecondsUnit() {
    seconds = currentDuration % 60;

    if (seconds == 0) {
      return Text(
        "${seconds.round()}0",
        style: textStyle(60, Colors.brown, FontWeight.bold),
      );
    } else {
      return Text(
        twoDigits(seconds),
        style: textStyle(60, Colors.brown, FontWeight.bold),
      );
    }
  }

  Widget? changeMinutesUnit() {
    minutes = currentDuration % 3600;

    if (minutes == 0) {
      return Text(
        "${minutes.round()}0",
        style: textStyle(60, Colors.brown, FontWeight.bold),
      );
    } else {
      return Text(
        twoDigits((minutes ~/ 60)),
        style: textStyle(60, Colors.brown, FontWeight.bold),
      );
    }
  }
}
