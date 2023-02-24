import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class TextFieldCustomBook extends StatefulWidget {
  final String label;

  const TextFieldCustomBook({super.key, required this.label});

  @override
  State<TextFieldCustomBook> createState() => _TextFieldCustomBookState();
}

class _TextFieldCustomBookState extends State<TextFieldCustomBook> {
  @override
  Widget build(BuildContext contex) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.01,
              horizontal: MediaQuery.of(context).size.width * 0.04),
          hintText: widget.label,
          hintStyle: TextStyle(color: context.resources.color.greyDarker),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: context.resources.color.colorDarkest),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: context.resources.color.colorDarkest),
          ),
        ),
      ),
    );
  }
}
