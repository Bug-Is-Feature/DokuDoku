import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class QuestBoardView extends StatefulWidget {
  const QuestBoardView({super.key});

  @override
  State<QuestBoardView> createState() => _QuestBoardViewState();
}

class _QuestBoardViewState extends State<QuestBoardView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width,
          color: context.resources.color.colorLightest,
          child: const Center(
            child: Text(
              'Quest Board',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: context.resources.color.colorLighter2,
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView(
              children: [
                // QuestCard(),
                // QuestCard(),
                // QuestCard(),
                // QuestCard(),
                // QuestCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
