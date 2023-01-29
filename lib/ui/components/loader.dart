import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: SpinKitRotatingCircle(
        color: context.resources.color.colorWhite,
        size: 50.0,
      ),
    );
  }
}
