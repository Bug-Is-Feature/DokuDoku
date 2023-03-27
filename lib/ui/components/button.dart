import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dokudoku/provider/timer_provider.dart';

class Button extends StatefulWidget {
  Widget child;
  VoidCallback onPressed;
  Color backgroundColor;
  bool isOutline;
  Size? size;

  Button({
    super.key,
    required this.child,
    required this.onPressed,
    required this.backgroundColor,
    this.isOutline = false,
    this.size,
  });
  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerProvider>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 20,
              fontFamily: 'primary',
            ),
            backgroundColor:
                widget.isOutline ? Colors.transparent : widget.backgroundColor,
            fixedSize: widget.size ?? widget.size,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: widget.isOutline
                    ? BorderSide(color: widget.backgroundColor)
                    : BorderSide.none),
            elevation: widget.isOutline ? 0 : 3,
          ),
          onPressed: widget.onPressed,
          child: widget.child,
        )
      ],
    );
  }
}
