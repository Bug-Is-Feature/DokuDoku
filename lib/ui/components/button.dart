import 'package:dokudoku/viewmodel/time_controller.dart';
import 'package:dokudoku/services/timer_service.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:provider/provider.dart';

class Button extends StatefulWidget {
  const Button({super.key});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20, fontFamily: 'primary'),
      backgroundColor: context.resources.color.colorDark,
      fixedSize: const Size(99, 44),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
    );
    final provider = Provider.of<TimerService>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
            style: style,
            onPressed: () {
              if (provider.timerPlaying) {
                Provider.of<TimerService>(context, listen: false).stop();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    alignment: Alignment.center,
                    title: Text(
                      "Your Time",
                      style: TextStyle(
                        fontFamily: 'primary',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: context.resources.color.colorDarkest,
                      ),
                    ),
                    content: Text(
                      provider.stopTime > 5
                          ? (provider.stopTime <= 10
                              ? '${provider.stopTime.round().toString()} sec (saved)'
                              : '${provider.stopTime.round().toString()} min (saved)')
                          : 'result not saved (less than 5 minutes)',
                      // provider.stopTime <= 60
                      //     ? '${provider.stopTime.round().toString()} sec'
                      //     : '${provider.stopTime.round().toString()} min',

                      style: TextStyle(
                        fontFamily: 'primary',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: context.resources.color.colorDarkest,
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'View Stat.',
                            style: TextStyle(
                              fontFamily: 'primary',
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: context.resources.color.colorDarkest,
                            ),
                          )),
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Close',
                            style: TextStyle(
                              fontFamily: 'primary',
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: context.resources.color.colorDarkest,
                            ),
                          )),
                    ],
                  ),
                );
                Provider.of<TimerService>(context, listen: false).reset();
              } else {
                Provider.of<TimerService>(context, listen: false).start();
              }
            },
            child: const Text('Start')),
      ],
    );
  }
}
