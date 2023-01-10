import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class Botton extends StatefulWidget {
  const Botton({super.key});

  @override
  State<Botton> createState() => _BottonState();
}

class _BottonState extends State<Botton> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 15),
      backgroundColor: context.resources.color.colorDark,
      fixedSize: const Size(99, 44),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          style: style,
          onPressed: () {},
          child: const Text('Start'),
        ),
      ],
    );
  }
}
