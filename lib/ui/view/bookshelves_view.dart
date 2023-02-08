import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dokudoku/ui/components/quest_card.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class BookShelvesView extends StatefulWidget {
  const BookShelvesView({super.key});

  @override
  State<BookShelvesView> createState() => _BookShelvesViewState();
}

class _BookShelvesViewState extends State<BookShelvesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: context.resources.color.colorDark,
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.logout),
      //       onPressed: () {
      //         FirebaseAuth.instance.signOut();
      //       },
      //     ),
      //   ],
      // ),
      backgroundColor: context.resources.color.colorLightest,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            color: context.resources.color.colorLighter2,
            child: Column(
              children: [],
            ),
          ),
          Expanded(
            child: Container(
              color: context.resources.color.colorWhite,
              child: ListView(
                children: [
                  QuestCard(),
                  QuestCard(),
                  QuestCard(),
                  QuestCard(),
                  QuestCard(),
                  QuestCard(),
                  QuestCard(),
                  QuestCard(),
                  QuestCard(),
                  QuestCard(),
                  QuestCard(),
                  QuestCard(),
                  QuestCard(),
                  QuestCard(),
                  QuestCard(),
                  QuestCard(),
                  QuestCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
