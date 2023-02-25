import 'package:dokudoku/ui/components/tabbar_filter_bookshelves.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SearchGoogleBookView extends StatefulWidget {
  const SearchGoogleBookView({super.key});

  @override
  State<SearchGoogleBookView> createState() => _SearchGoogleBookViewState();
}

class _SearchGoogleBookViewState extends State<SearchGoogleBookView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarFilterBookshelves(),
    );
  }
}
