import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/ui/components/botton.dart';
import 'package:dokudoku/ui/components/navigation_drawer.dart';
import 'package:dokudoku/ui/components/toggle_timer_button.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 3;
  static final List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Timer',
    ),
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
    String timer = 'Timer';
    String quest = 'Quest';
    String bookShelves = 'BookShelves';
    String profile = 'Profile';
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Theme(
        data: theme.copyWith(
            canvasColor: context.resources.color.colorDarkest,
            colorScheme: theme.colorScheme.copyWith(
              primary: context.resources.color.colorLightest,
            )),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          iconSize: 30,
          onTap: _onItemTapped,
          elevation: 10,
          showSelectedLabels: false,
          showUnselectedLabels: false,

          // selectedItemColor: context.resources.color.colorLightest,
          // unselectedItemColor: context.resources.color.colorDark,
          items: [
            BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_timer_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_timer_filled),
              label: timer,
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_assignments_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_assignments_filled),
              label: quest,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              activeIcon: Icon(Icons.book),
              label: bookShelves,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined),
              activeIcon: Icon(Icons.person),
              label: profile,
            ),
          ],
        ),
      ),
    );
  }
}
