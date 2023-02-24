import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    Color backgroundColor = Colors.transparent,
  }) : super(
          backgroundColor: backgroundColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.brown),
        );
}
