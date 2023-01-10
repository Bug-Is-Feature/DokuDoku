import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToggleTimerButton extends StatefulWidget {
  const ToggleTimerButton({super.key});

  @override
  State<ToggleTimerButton> createState() => _ToggleTimerButtonState();
}

class _ToggleTimerButtonState extends State<ToggleTimerButton> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        textTheme: theme.textTheme.copyWith(
          headline1: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'primary',
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ToggleSwitch(
              minWidth: 140,
              initialLabelIndex: 0,
              activeBgColor: [context.resources.color.colorDarkest],
              activeFgColor: context.resources.color.colorNormal2,
              inactiveBgColor: context.resources.color.colorWhite,
              inactiveFgColor: context.resources.color.colorDarkest,
              radiusStyle: true,
              icons: [
                FontAwesomeIcons.stopwatch,
                FontAwesomeIcons.hourglassEnd,
              ],
              labels: ['Stopwatch', 'Hourglass'],
              cornerRadius: 20,
              onToggle: (index) {
                print('switched to: $index');
              },
              fontSize: 18,
            ),
          ],
        ),
      ),
    );
  }
}
