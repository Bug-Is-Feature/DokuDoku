import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/ui/view/bookShelves_view.dart';
import 'package:dokudoku/ui/view/profile_view.dart';
import 'package:dokudoku/ui/view/quest_board_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar {
  static List<BottomNavigationBarItem> listItemBottomBar = [
    BottomNavigationBarItem(
      icon: Column(
        children: const [
          Icon(
            Icons.book_outlined,
            color: Colors.white,
            size: 24,
          ),
          Text(
            'BookShelves',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      activeIcon: Column(
        children: const [
          Icon(
            Icons.book,
            color: Colors.white,
            size: 24,
          ),
          Text(
            'BookShelves',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      label: "BookShelves",
    ),
    BottomNavigationBarItem(
      icon: Column(
        children: const [
          Icon(
            Icons.assignment_outlined,
            color: Colors.white,
            size: 24,
          ),
          Text(
            'Quest Board',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      activeIcon: Column(
        children: const [
          Icon(
            Icons.assignment,
            color: Colors.white,
            size: 24,
          ),
          Text(
            'Quest Board',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      label: "Quest Board",
    ),
    BottomNavigationBarItem(
        icon: Column(
          children: const [
            Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 24,
            ),
            Text(
              'Profile',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        activeIcon: Column(
          children: const [
            Icon(
              Icons.person,
              color: Colors.white,
              size: 24,
            ),
            Text(
              'Profile',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        label: "Profile"),
  ];

  static double elevation = 10;

  static bool showSelectedLabels = false;

  static bool showUnselectedLabels = false;

  static BottomNavigationBarType bottomNavigationBarType =
      BottomNavigationBarType.fixed;

  static Color selectedItemColor = Colors.white;

  static Color unSelectedItemColor = Colors.white;
}















// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});

//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   int _selectedIndex = 0;
//   static final List<Widget> _widgetOptions = <Widget>[
//     BookShelvesView(),
//     QuestBoardView(),
//     ProfileView()
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     String quest = 'Quest';
//     String bookShelves = 'BookShelves';
//     String profile = 'Profile';
//     ThemeData theme = Theme.of(context);

//     return Theme(
//       data: theme.copyWith(
//         canvasColor: context.resources.color.colorDarkest,
//         colorScheme: theme.colorScheme.copyWith(
//           primary: context.resources.color.colorLightest,
//         ),
//       ),
//       child: Scaffold(
//         body: _widgetOptions[_selectedIndex],
//         bottomNavigationBar: SizedBox(
//           height: 70,
//           child: BottomNavigationBar(
//             type: BottomNavigationBarType.fixed,
//             currentIndex: _selectedIndex,
//             onTap: _onItemTapped,
//             elevation: 10,
//             showSelectedLabels: false,
//             showUnselectedLabels: false,
//             unselectedItemColor: context.resources.color.colorWhite,
//             items: [
//               BottomNavigationBarItem(
//                 icon: Column(
//                   children: [
//                     Icon(
//                       Icons.book_outlined,
//                       color: context.resources.color.colorWhite,
//                       size: 24,
//                     ),
//                     Text(
//                       'BookShelves',
//                       style:
//                           TextStyle(color: context.resources.color.colorWhite),
//                     )
//                   ],
//                 ),
//                 activeIcon: Column(
//                   children: [
//                     Icon(
//                       Icons.book,
//                       color: context.resources.color.colorWhite,
//                       size: 24,
//                     ),
//                     Text(
//                       'BookShelves',
//                       style:
//                           TextStyle(color: context.resources.color.colorWhite),
//                     )
//                   ],
//                 ),
//                 label: quest,
//               ),
//               BottomNavigationBarItem(
//                 icon: Column(
//                   children: [
//                     Icon(
//                       Icons.assignment_outlined,
//                       size: 24,
//                     ),
//                     Text(
//                       'Quest Board',
//                       style:
//                           TextStyle(color: context.resources.color.colorWhite),
//                     )
//                   ],
//                 ),
//                 activeIcon: Column(
//                   children: [
//                     Icon(
//                       Icons.assignment,
//                       size: 24,
//                     ),
//                     Text(
//                       'Quest Board',
//                       style:
//                           TextStyle(color: context.resources.color.colorWhite),
//                     )
//                   ],
//                 ),
//                 label: bookShelves,
//               ),
//               BottomNavigationBarItem(
//                 icon: Column(
//                   children: [
//                     Icon(
//                       Icons.person_outline,
//                       size: 24,
//                     ),
//                     Text(
//                       'Profile',
//                       style:
//                           TextStyle(color: context.resources.color.colorWhite),
//                     )
//                   ],
//                 ),
//                 activeIcon: Column(
//                   children: [
//                     Icon(
//                       Icons.person,
//                       size: 24,
//                     ),
//                     Text(
//                       'Profile',
//                       style:
//                           TextStyle(color: context.resources.color.colorWhite),
//                     )
//                   ],
//                 ),
//                 label: profile,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
