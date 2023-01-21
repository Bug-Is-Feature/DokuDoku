import 'package:dokudoku/enums/NavigationItem.dart';
import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  NavigationItem _navigationItem = NavigationItem.profile;

  NavigationItem get navigationItem => _navigationItem;

  void setNavigationItem(NavigationItem navigationItem) {
    _navigationItem = navigationItem;
    notifyListeners();
  }
}
