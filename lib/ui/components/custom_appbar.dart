import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    required Key key,
    Color backgroundColor = Colors.white,
  }) : super(
          key: key,
          backgroundColor: backgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.brown),
        );
}
