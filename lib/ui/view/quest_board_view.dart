import 'package:dokudoku/ui/components/quest_card.dart';
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
    return Scaffold(
      backgroundColor: context.resources.color.colorLightest,
      body: Container(
        child: Container(
          color: context.resources.color.colorNormal3,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              children: const [
                QuestCard(),
                QuestCard(),
                QuestCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
