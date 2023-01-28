import 'dart:async';

import 'package:dokudoku/ui/components/custom_dialog_box.dart';
import 'package:dokudoku/ui/view/home_view.dart';
import 'package:dokudoku/ui/view/hourglass_view.dart';
import 'package:flutter/material.dart';

enum TimerState { focus, cancel, breakTime, end, pause }

enum TimerMode { unMode, stopwatch, hourglass }

class TimerService extends ChangeNotifier {
  final sessionController = TextEditingController();
  final sessionNumController = TextEditingController();
  final breakController = TextEditingController();

  int inputSession = 0;
  int inputSessionNum = 0;
  int inputBreak = 0;

  int sumTime = 0;
  int iteration = 1;
  TimerMode currentMode = TimerMode.unMode;
  TimerState currentState = TimerState.focus;
  int currentDurationHrg = 0;

  int currentDuration = 0;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  int totalDuration = 0;
  bool timerPlaying = false;
  String twoDigits(int n) => n.round().toString().padLeft(2, '0');
  Timer? timer;

  void submitData(BuildContext context) {
    inputSession = int.parse(sessionController.text) * 60;
    inputSessionNum = int.parse(sessionNumController.text);
    inputBreak = int.parse(breakController.text) * 60;

    if (currentState == TimerState.cancel || currentState == TimerState.end) {
      iteration = 1;
      sumTime = 0;
      currentState = TimerState.focus;
      currentDurationHrg = 0;
      currentDurationHrg = inputSession;
      startHourglass(context);
    } else {
      currentDurationHrg = inputSession;
      startHourglass(context);
    }
    notifyListeners();
  }

  void validator(BuildContext context) {
    final sessionCheck = sessionController.value.text;
    final sessionNumCheck = sessionNumController.value.text;
    final breakCheck = breakController.value.text;

    if (sessionCheck.isEmpty || sessionNumCheck.isEmpty || breakCheck.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xff2AA16),
          content: Text(
            'Please enter number',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'primary',
                fontSize: 16),
          ),
        ),
      );
    } else if (int.parse(sessionCheck) < 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xff2AA16),
          content: Text(
            'Please enter Reading Duration more than 5 minutes',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'primary',
                fontSize: 16),
          ),
        ),
      );
    } else if (int.parse(sessionCheck) > 60) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xff2AA16),
          content: Text(
            'limit of Reading Duration is 1 hours',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'primary',
                fontSize: 16),
          ),
        ),
      );
    } else if (int.parse(sessionCheck) >= 5 || int.parse(breakCheck) >= 5) {
      submitData(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const HourglassView();
          },
        ),
      );
    }
  }

  void startHourglass(BuildContext context) {
    currentMode = TimerMode.hourglass;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (currentDurationHrg == 0) {
          handleNextIteration(context);
        } else {
          currentDurationHrg--;
          notifyListeners();
        }
      },
    );
  }

  void pauseHourglass() {
    if (currentState == TimerState.focus) {
      sumTime += (inputSession - currentDurationHrg);
    }
    timer!.cancel();
    notifyListeners();
  }

  void stopHourglass() {
    timer!.cancel();
    currentState = TimerState.end;
    notifyListeners();
  }

  void cancelSession(BuildContext context) {
    timer!.cancel();
    currentState = TimerState.cancel;
    notifyListeners();
  }

  void skipBreak(BuildContext context) {
    timer!.cancel();
    currentState = TimerState.focus;
    currentDurationHrg = inputSession;
    notifyListeners();
  }

  void handleNextIteration(BuildContext context) {
    if (currentState == TimerState.focus) {
      if (iteration < inputSessionNum) {
        sumTime += (inputSession - currentDurationHrg);
        currentState = TimerState.breakTime;
        currentDurationHrg = inputBreak;
        iteration++;
      } else if (iteration >= inputSessionNum) {
        sumTime += (inputSession - currentDurationHrg);
        stopHourglass();
        fullTimeDialog(context);
      }
    } else if (currentState == TimerState.breakTime) {
      currentState = TimerState.focus;
      currentDurationHrg = inputSession;
    }
    notifyListeners();
  }

  void cancelTimeDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => CustomDialog(
        title: 'Give up?',
        description:
            "Your progress won't record.\nYou've already read\n${formattedTotalDuration(sumTime)}",
        buttonText: 'Yes',
        onPressed: () {
          cancelSession(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const HomeView();
              },
            ),
          );
        },
        buttonText2: 'No',
        onPressed2: () {
          if (currentState == TimerState.focus) {
            sumTime -= inputSession - currentDurationHrg;
          }
          Navigator.of(ctx).pop();
          startHourglass(context);
        },
      ),
    );
  }

  void breakTimeDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx2) => CustomDialog(
        title: 'Skip the break?',
        description: '',
        buttonText: 'Yes',
        buttonText2: 'No',
        onPressed: () {
          if (currentState == TimerState.breakTime) {
            skipBreak(context);
          }
          Navigator.of(ctx2).pop();
          startHourglass(context);
        },
        onPressed2: () {
          if (currentState == TimerState.focus) {
            sumTime -= inputSession - currentDurationHrg;
          }
          Navigator.of(ctx2).pop();
          startHourglass(context);
        },
      ),
    );
  }

  void fullTimeDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx3) => CustomDialog(
        title: 'Success',
        description: "You've already read\n${formattedTotalDuration(sumTime)}.",
        buttonText: 'Ok',
        onPressed: () {
          Navigator.push(
            ctx3,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const HomeView();
              },
            ),
          );
        },
      ),
    );
  }

  void start(BuildContext context) {
    timerPlaying = true;
    currentMode = TimerMode.stopwatch;
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
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CustomDialog(
        title: 'Success',
        description: formattedTotalDuration(totalDuration),
        buttonText: "View Stat",
        buttonText2: 'Close',
        onPressed2: () {
          currentMode = TimerMode.unMode;
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

  String formattedTotalDuration(int time) {
    return "${formattedHours(time)} h: ${formattedMinutes(time)} m: ${formattedSeconds(time)} s";
  }
}
