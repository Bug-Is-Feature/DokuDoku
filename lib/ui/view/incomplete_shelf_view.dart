import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/ui/components/quest_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class IncompleteShelfView extends StatefulWidget {
  const IncompleteShelfView({super.key});

  @override
  State<IncompleteShelfView> createState() => _IncompleteShelfViewState();
}

class _IncompleteShelfViewState extends State<IncompleteShelfView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        backgroundColor: context.resources.color.colorDarkest,
        icon: Icons.add,
        children: [
          SpeedDialChild(
            backgroundColor: context.resources.color.colorDark,
            child:
                Icon(Icons.search, color: context.resources.color.colorWhite),
            label: 'Search Book',
            onTap: () {},
          ),
          SpeedDialChild(
            backgroundColor: context.resources.color.colorDark,
            child: Icon(
              Icons.my_library_add,
              color: context.resources.color.colorWhite,
            ),
            label: 'Add Book',
            onTap: () {},
          ),
          SpeedDialChild(
            backgroundColor: context.resources.color.colorDark,
            child: Icon(
              Icons.camera_alt,
              color: context.resources.color.colorWhite,
            ),
            label: 'Add Quest',
            onTap: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [QuestCard()],
        ),
      ),
    );
  }
}
