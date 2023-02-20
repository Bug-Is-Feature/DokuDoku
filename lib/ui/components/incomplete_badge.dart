import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class IncompleteStatusBadge extends StatefulWidget {
  const IncompleteStatusBadge({super.key});

  @override
  State<IncompleteStatusBadge> createState() => _IncompleteStatusBadgeState();
}

class _IncompleteStatusBadgeState extends State<IncompleteStatusBadge> {
  String incompleteCost = '32.5 Baht';
  String incompletePercent = '50';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 60,
      child: Container(
        decoration: BoxDecoration(
          color: context.resources.color.colorDark,
          borderRadius: BorderRadius.circular(80),
          boxShadow: List.generate(
            3,
            (index) => BoxShadow(
              color: context.resources.color.grey,
              blurRadius: 2,
              offset: Offset(0, 3),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Incomplete cost',
                  style: TextStyle(
                      fontSize: 18, color: context.resources.color.colorWhite),
                ),
                Text(
                  '$incompleteCost',
                  style: TextStyle(
                      fontSize: 18, color: context.resources.color.colorWhite),
                )
              ],
            ),
            VerticalDivider(
              color: context.resources.color.colorDarkest,
              thickness: 2,
              indent: 18,
              endIndent: 18,
              width: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Incomplete percent",
                  style: TextStyle(
                      fontSize: 18, color: context.resources.color.colorWhite),
                ),
                Text(
                  '$incompletePercent %',
                  style: TextStyle(
                      fontSize: 18, color: context.resources.color.colorWhite),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
