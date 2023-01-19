import 'package:dokudoku/ui/components/bottom_navbar.dart';
import 'package:dokudoku/ui/components/custom_appbar.dart';
import 'package:dokudoku/ui/components/hourglass_session_input.dart';
import 'package:dokudoku/ui/components/navigation_drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class HourglassView extends StatefulWidget {
  const HourglassView({super.key});

  @override
  State<HourglassView> createState() => _HourglassViewState();
}

class _HourglassViewState extends State<HourglassView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.resources.color.colorLightest,
      body: Center(
          child: Container(
              child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Container(
            child: Text(
              "24:59",
              style: TextStyle(fontSize: 50),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
                color: context.resources.color.colorWhite,
                borderRadius: BorderRadius.circular(60),
                boxShadow: [
                  BoxShadow(
                    color: context.resources.color.grey,
                    blurRadius: 5,
                    offset: Offset(0, 4),
                  ),
                ]),
          )
        ],
      ))),
    );
  }
}
