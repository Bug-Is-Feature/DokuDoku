import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class DropdownBooksheleves extends StatefulWidget {
  const DropdownBooksheleves({super.key});

  @override
  State<DropdownBooksheleves> createState() => _DropdownBookshelevesState();
}

class _DropdownBookshelevesState extends State<DropdownBooksheleves> {
  String dropdownValue = 'Incomplete';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.028,
      width: MediaQuery.of(context).size.width * 0.33,
      child: DropdownButtonFormField(
        items: <String>['Incomplete', 'Complete']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        value: dropdownValue,
        onChanged: dropdownCallback,
        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          color: context.resources.color.colorDarkest,
          size: 20,
        ),
        borderRadius: BorderRadius.circular(30),
        isExpanded: true,
        isDense: true,
        style: TextStyle(
          fontSize: 10,
          color: context.resources.color.colorDarkest,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.check,
            color: context.resources.color.positive,
            size: 20,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0,
            horizontal: MediaQuery.of(context).size.width * 0.01,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: context.resources.color.colorDarkest),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: context.resources.color.colorDarkest),
          ),
        ),
      ),
    );
  }

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        dropdownValue = selectedValue;
      });
    }
  }
}
