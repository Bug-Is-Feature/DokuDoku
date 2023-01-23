import 'package:dokudoku/ui/components/button.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class QuestCard extends StatefulWidget {
  const QuestCard({super.key});

  @override
  State<QuestCard> createState() => _QuestCardState();
}

class _QuestCardState extends State<QuestCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: context.resources.color.grey,
              blurRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Reading 15 Minutes',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Row(
                              children: [
                                Text('Reward : -15 EXP'),
                                SizedBox(width: 10),
                                SizedBox(
                                  width: 100,
                                  height: 5,
                                  child: LinearProgressIndicator(
                                    value: 0.5,
                                    backgroundColor:
                                        context.resources.color.grey,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        context.resources.color.colorDarkest),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Button(
                child: Text('Lock'),
                onPressed: () {},
                backgroundColor: context.resources.color.colorDark,
                size: Size(85, 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
