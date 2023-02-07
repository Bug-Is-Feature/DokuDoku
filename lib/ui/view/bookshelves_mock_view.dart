import 'package:dokudoku/ui/components/search_box.dart';
import 'package:flutter/material.dart';

class BookshelvesView extends StatelessWidget {
  const BookshelvesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchBox(),
    );
  }
}
