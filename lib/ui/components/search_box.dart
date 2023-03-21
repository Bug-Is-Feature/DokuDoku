import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class SearchBox extends StatefulWidget {
  final String label;
  double width;
  String hintText = 'Search';
  final ValueChanged<String> onChanged;
  String text;

  SearchBox({
    super.key,
    required this.label,
    required this.width,
    required this.onChanged,
    required this.text,
  });

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: widget.width,
        height: MediaQuery.of(context).size.height * 0.042,
        child: TextField(
          controller: controller,
          onChanged: widget.onChanged,
          cursorColor: context.resources.color.colorDarkest,
          cursorHeight: MediaQuery.of(context).size.height * 0.03,
          decoration: InputDecoration(
            suffixIcon: widget.text.isNotEmpty
                ? GestureDetector(
                    child: Icon(Icons.close,
                        color: context.resources.color.colorDark),
                    onTap: () {
                      controller.clear();
                      widget.onChanged('');
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  )
                : null,
            hintText: widget.hintText,
            hintStyle: TextStyle(
                color: context.resources.color.greyDark, fontSize: 18),
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
