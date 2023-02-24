import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class SearchBox extends StatefulWidget {
  final String label;
  const SearchBox({super.key, required this.label});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.50,
        height: MediaQuery.of(context).size.height * 0.042,
        child: TextField(
          cursorColor: context.resources.color.colorDarkest,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.01,
                horizontal: MediaQuery.of(context).size.width * 0.04),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: context.resources.color.colorDarkest),
            ),
            fillColor: context.resources.color.colorWhite,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: context.resources.color.colorDarkest),
            ),
            hintText: widget.label,
            hintStyle: TextStyle(
                color: context.resources.color.greyDarker, fontSize: 18),
            prefixIcon: Container(
              height: MediaQuery.of(context).size.height * 0.01,
              width: MediaQuery.of(context).size.width * 0.05,
              child: Icon(Icons.search,
                  color: context.resources.color.colorDarkest),
            ),
          ),
        ),
      ),
    );
  }
}
