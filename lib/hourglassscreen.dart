import 'package:flutter/material.dart';
import 'package:dokudoku/widgets/dialogbox.dart';
import 'package:dokudoku/widgets/displaytimer.dart';
import 'package:dokudoku/widgets/timecontroller.dart';

class HourglassScreen extends StatelessWidget {
  const HourglassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: const [
              DisplayTimer(),
              DialogBox(),
              SizedBox(
                height: 20,
              ),
              TimeController(),
            ],
          ),
        ),
      ),
    );
  }
}
