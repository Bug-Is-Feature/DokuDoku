import 'package:dokudoku/ui/components/button.dart';
import 'package:dokudoku/ui/components/stopwatch_timer.dart';
import 'package:dokudoku/ui/components/timer_display.dart';
import 'package:dokudoku/ui/components/timer_mode_tabbar.dart';
import 'package:dokudoku/ui/components/toggle_timer_button.dart';
import 'package:dokudoku/viewmodel/time_controller.dart';

import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class StopwatchView extends StatelessWidget {
  const StopwatchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.resources.color.colorLightest,
      body: Center(
          child: Container(
              child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          StopwatchTimer(),
          SizedBox(
            height: 60,
          ),
          Button()
        ],
      ))),
    );
  }
}
