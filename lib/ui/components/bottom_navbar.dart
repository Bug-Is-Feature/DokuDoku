import 'package:flutter/material.dart';

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
