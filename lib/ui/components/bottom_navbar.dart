import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/ui/components/button.dart';
import 'package:dokudoku/ui/components/navigation_drawer.dart';
import 'package:dokudoku/ui/view/hourglass_view.dart';
import 'package:dokudoku/ui/view/note_history_view.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 2;
  static final List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 1: Assignments',
    ),
    Text(
      'Index 2: Books',
    ),
    Text(
      'Index 3: Profile',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String quest = 'Quest';
    String bookShelves = 'BookShelves';
    String profile = 'Profile';
    ThemeData theme = Theme.of(context);

    return Theme(
      data: theme.copyWith(
        canvasColor: context.resources.color.colorDarkest,
        colorScheme: theme.colorScheme.copyWith(
          primary: context.resources.color.colorLightest,
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        iconSize: 30,
        onTap: _onItemTapped,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,

        // selectedItemColor: context.resources.color.colorLightest,
        unselectedItemColor: context.resources.color.colorWhite,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.addressCard),
            activeIcon: Icon(FontAwesomeIcons.solidRectangleList),
            label: quest,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              IconData(0xe15b, fontFamily: 'MaterialIcons'),
            ),
            activeIcon: Icon(FontAwesomeIcons.solidAddressBook),
            label: bookShelves,
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userCircle),
            activeIcon: Icon(FontAwesomeIcons.solidUserCircle),
            label: profile,
          ),
        ],
      ),
    );
  }
}
