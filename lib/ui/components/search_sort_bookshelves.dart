// ignore_for_file: prefer_const_constructors

import 'package:dokudoku/ui/components/sort_by_button.dart';
import 'package:flutter/material.dart';
import 'search_box.dart';

class SearchSortBookshelves extends StatefulWidget {
  const SearchSortBookshelves({super.key});

  @override
  State<SearchSortBookshelves> createState() => _SearchSortBookshelvesState();
}

class _SearchSortBookshelvesState extends State<SearchSortBookshelves> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Expanded(
            child: SearchBox(
              text: '',
              onChanged: (value) {},
              label: 'Search',
              width: MediaQuery.of(context).size.width * 0.50,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          SortByButton()
        ],
      ),
    );
  }
}
