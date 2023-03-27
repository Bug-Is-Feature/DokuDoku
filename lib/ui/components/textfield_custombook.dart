import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:flutter/services.dart';

class TextFieldCustomBook extends StatefulWidget {
  final String label;
  final String labelText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(dynamic value) validator;
  final TextInputFormatter inputFormatter;
  late var maxLines;

  TextFieldCustomBook(
      {super.key,
      required this.label,
      required this.controller,
      required this.validator,
      required this.keyboardType,
      required this.inputFormatter,
      required this.labelText,
      required this.maxLines});

  @override
  State<TextFieldCustomBook> createState() => _TextFieldCustomBookState();
}

class _TextFieldCustomBookState extends State<TextFieldCustomBook> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        maxLines: widget.maxLines,
        inputFormatters: [widget.inputFormatter],
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: context.resources.color.colorWhite,
          labelText: widget.labelText,
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
