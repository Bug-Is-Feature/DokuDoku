import 'dart:async';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/ui/components/custom_dialog_box.dart';
import 'package:dokudoku/ui/components/snack_bar_utils.dart';
import 'package:dokudoku/ui/view/hourglass_view.dart';
import 'package:flutter/material.dart';

enum TimerState { focus, breakTime, end }

enum TimerMode { none, stopwatch, hourglass }

class TimerService extends ChangeNotifier {
  final sessionDurationController = TextEditingController();
  final sessionIterationController = TextEditingController();
  final breakDurationController = TextEditingController();

  int inputSession = 0;
  int inputSessionNum = 0;
  int inputBreak = 0;

  int sumTime = 0;
  int iteration = 1;
  TimerMode currentMode = TimerMode.none;
  TimerState currentState = TimerState.focus;

  int currentDuration = 0;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  int totalDuration = 0;
  bool timerPlaying = false;
  String twoDigits(int n) => n.round().toString().padLeft(2, '0');
  Timer? timer;

  void submitData(BuildContext context) {
    inputSession = int.parse(sessionDurationController.text);
    inputSessionNum = int.parse(sessionIterationController.text);
    inputBreak = int.parse(breakDurationController.text);

    if (currentState == TimerState.end) {
      iteration = 1;
      sumTime = 0;
      currentState = TimerState.focus;
      currentDuration = 0;
      currentDuration = inputSession;
      startHourglass(context);
    } else {
      currentDuration = inputSession;
      startHourglass(context);
    }
    notifyListeners();
  }

  void validator(BuildContext context) {
    if (sessionDurationController.text.isEmpty ||
        sessionIterationController.text.isEmpty ||
        breakDurationController.text.isEmpty) {
      SnackBarUtils.showWarningSnackBar(
        context: context,
        content: 'Please enter number in every form.',
      );
    }

    final sessionDuration = int.parse(sessionDurationController.value.text);

    if (sessionDuration < 5) {
      SnackBarUtils.showCustomSnackBar(
        context: context,
        backgroundColor: context.resources.color.warning,
        content: 'Please enter Reading Duration more than 5 minutes',
      );
    } else if (sessionDuration > 60) {
      SnackBarUtils.showWarningSnackBar(
        context: context,
        content: 'limit of Reading Duration is 1 hours',
      );
    } else {
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
        if (currentDuration == 0) {
          handleNextIteration(context);
        } else {
          currentDuration--;
          notifyListeners();
        }
      },
    );
  }

  void pauseHourglass() async {
    if (currentState == TimerState.focus) {
      sumTime += (inputSession - currentDuration);
    }
    timer!.cancel();
    notifyListeners();
  }

  void stopHourglass(BuildContext context) {
    timer!.cancel();
    currentState = TimerState.end;
    notifyListeners();
  }

  void skipBreak(BuildContext context) {
    timer!.cancel();
    currentState = TimerState.focus;
    currentDuration = inputSession;
    notifyListeners();
  }

  void handleNextIteration(BuildContext context) {
    if (currentState == TimerState.focus) {
      if (iteration < inputSessionNum) {
        sumTime += (inputSession - currentDuration);
        currentState = TimerState.breakTime;
        currentDuration = inputBreak;
        iteration++;
      } else if (iteration >= inputSessionNum) {
        sumTime += (inputSession - currentDuration);
        stopHourglass(context);
        fullTimeDialog(context);
      }
    } else if (currentState == TimerState.breakTime) {
      currentState = TimerState.focus;
      currentDuration = inputSession;
    }
    notifyListeners();
  }

  Future<bool> cancelTimeDialog(
      {required BuildContext context, required bool isWillPop}) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => CustomDialog(
        title: 'Give up?',
        description:
            "Your progress won't record.\nYou've already read\n${formattedTotalDuration(sumTime)}",
        buttonText: 'Yes',
        onPressed: () {
          stopHourglass(context);
          currentDuration = 0;
          if (isWillPop) {
            Navigator.of(context).pop(true);
          } else {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
        buttonText2: 'No',
        onPressed2: () {
          if (currentState == TimerState.focus) {
            sumTime -= inputSession - currentDuration;
          }
          Navigator.of(ctx).pop(false);
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
            sumTime -= inputSession - currentDuration;
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
          //   Navigator.push(
          //     ctx3,
          //     MaterialPageRoute(
          //       builder: (BuildContext context) {
          //         return const HomeView();
          //       },
          //     ),
          //   );
          Navigator.of(context).popUntil((route) => route.isFirst);
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
          currentMode = TimerMode.none;
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
