import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return (Container(
      width: MediaQuery.of(context).size.width * 0.5,
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: TextField(
                  cursorColor: context.resources.color.colorDarkest,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: context.resources.color.colorDarkest),
                    ),
                    fillColor: context.resources.color.colorWhite,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: context.resources.color.colorDarkest),
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                        color: context.resources.color.greyDarker,
                        fontSize: 18),
                    prefixIcon: Container(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.search,
                          color: context.resources.color.colorDarkest),
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
