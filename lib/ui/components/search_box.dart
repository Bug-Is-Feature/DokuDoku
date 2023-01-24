import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return (Container(
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: TextField(
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    prefixIcon: Container(
                      padding: EdgeInsets.all(15),
                      child: Icon(Icons.search),
                      width: MediaQuery.of(context).size.width,
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
