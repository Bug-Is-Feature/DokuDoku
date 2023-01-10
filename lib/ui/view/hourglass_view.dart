import 'package:dokudoku/ui/components/bottom_navbar.dart';
import 'package:dokudoku/ui/components/custom_appbar.dart';
import 'package:dokudoku/ui/components/navigation_drawer.dart';
import 'package:dokudoku/ui/components/toggle_timer_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class HourglassView extends StatefulWidget {
  const HourglassView({super.key});

  @override
  State<HourglassView> createState() => _HourglassViewState();
}

class _HourglassViewState extends State<HourglassView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.resources.color.colorLightest,
      body: Center(
          child: Container(
              child: Column(
        children: [
          ToggleTimerButton(),

          // TimeController(),
          SizedBox(
            height: 60,
          ),
          Text('Hourglass')
        ],
      ))),
    );
  }
}
