import 'package:flutter/material.dart';
import 'package:dokudoku/submitscreen.dart';
import 'package:dokudoku/timeservice.dart';
import 'package:provider/provider.dart';
import 'package:dokudoku/utils.dart';

class TimeController extends StatefulWidget {
  const TimeController({super.key});

  @override
  State<TimeController> createState() => _TimeControllerState();
}

class _TimeControllerState extends State<TimeController> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: Colors.redAccent,
      foregroundColor: Colors.white,
      minimumSize: const Size(89, 44),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
    );

    return Center(
      child: TextButton(
        style: flatButtonStyle,
        onPressed: () {
          Provider.of<TimerService>(context, listen: false).stop();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              alignment: Alignment.center,
              title: Text(
                'Do you want to cancel your session?',
                style: textStyle(22),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Provider.of<TimerService>(context, listen: false)
                          .cancelSession();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const SubmitScreen();
                      }));
                    },
                    child: Text(
                      'Yes',
                      style: textStyle(16),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Provider.of<TimerService>(context, listen: false).start();
                    },
                    child: Text(
                      'No',
                      style: textStyle(16),
                    )),
              ],
            ),
          );
        },
        child: const Text('Cancel'),
      ),
    );
  }
}
