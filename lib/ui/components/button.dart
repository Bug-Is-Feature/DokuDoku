import 'package:dokudoku/viewmodel/time_controller.dart';
import 'package:dokudoku/services/timer_service.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:provider/provider.dart';

class Button extends StatefulWidget {
  Widget child;
  VoidCallback onPressed;
  late String buttonText;
  late Color backgroundColor;

  Button(
      {required this.child,
      required this.onPressed,
      buttonText,
      style,
      required this.backgroundColor});
  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    // final ButtonStyle style = ElevatedButton.styleFrom(
    //   textStyle: const TextStyle(fontSize: 20, fontFamily: 'primary'),
    //   // backgroundColor: context.resources.color.colorDark,
    //   fixedSize: const Size(99, 44),
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(100),
    //   ),
    // );
    final provider = Provider.of<TimerService>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20, fontFamily: 'primary'),
            backgroundColor: widget.backgroundColor,
            fixedSize: const Size(99, 44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          onPressed: widget.onPressed,
          child: widget.child,
        )
      ],
    );
  }
}
