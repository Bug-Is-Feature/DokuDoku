// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:auto_route/empty_router_widgets.dart' as _i1;
import 'package:flutter/material.dart' as _i10;

import '../ui/components/timer_mode_tabbar.dart' as _i8;
import '../ui/view/auth_view.dart' as _i2;
import '../ui/view/book_details_view.dart' as _i5;
import '../ui/view/bookshelves_view.dart' as _i4;
import '../ui/view/home_view.dart' as _i3;
import '../ui/view/profile_view.dart' as _i7;
import '../ui/view/quest_board_view.dart' as _i6;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    AuthViewRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.AuthView(),
      );
    },
    HomeViewRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomeView(),
      );
    },
    TimerRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    BookShelvesRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    QuestBoardRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    BookShelvesViewRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.BookShelvesView(),
      );
    },
    BookDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<BookDetailsRouteArgs>(
          orElse: () =>
              BookDetailsRouteArgs(bookID: pathParams.getInt('bookID')));
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.BookDetailsView(
          key: args.key,
          bookID: args.bookID,
        ),
      );
    },
    QuestBoardViewRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.QuestBoardView(),
      );
    },
    ProfileViewRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.ProfileView(),
      );
    },
    TimerModeTabBarRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.TimerModeTabBar(),
      );
    },
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(
          AuthRoute.name,
          path: '/auth',
          children: [
            _i9.RouteConfig(
              AuthViewRoute.name,
              path: '',
              parent: AuthRoute.name,
            )
          ],
        ),
        _i9.RouteConfig(
          HomeRoute.name,
          path: '/',
          children: [
            _i9.RouteConfig(
              '#redirect',
              path: '',
              parent: HomeRoute.name,
              redirectTo: 'home',
              fullMatch: true,
            ),
            _i9.RouteConfig(
              HomeViewRoute.name,
              path: 'home',
              parent: HomeRoute.name,
              children: [
                _i9.RouteConfig(
                  BookShelvesRoute.name,
                  path: 'book_shelves',
                  parent: HomeViewRoute.name,
                  children: [
                    _i9.RouteConfig(
                      BookShelvesViewRoute.name,
                      path: '',
                      parent: BookShelvesRoute.name,
                    ),
                    _i9.RouteConfig(
                      BookDetailsRoute.name,
                      path: ':bookID',
                      parent: BookShelvesRoute.name,
                    ),
                  ],
                ),
                _i9.RouteConfig(
                  QuestBoardRoute.name,
                  path: 'quest_board',
                  parent: HomeViewRoute.name,
                  children: [
                    _i9.RouteConfig(
                      QuestBoardViewRoute.name,
                      path: '',
                      parent: QuestBoardRoute.name,
                    )
                  ],
                ),
                _i9.RouteConfig(
                  ProfileRoute.name,
                  path: 'profile',
                  parent: HomeViewRoute.name,
                  children: [
                    _i9.RouteConfig(
                      ProfileViewRoute.name,
                      path: '',
                      parent: ProfileRoute.name,
                    )
                  ],
                ),
              ],
            ),
            _i9.RouteConfig(
              TimerRoute.name,
              path: 'timer',
              parent: HomeRoute.name,
              children: [
                _i9.RouteConfig(
                  TimerModeTabBarRoute.name,
                  path: '',
                  parent: TimerRoute.name,
                )
              ],
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.EmptyRouterPage]
class AuthRoute extends _i9.PageRouteInfo<void> {
  const AuthRoute({List<_i9.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          path: '/auth',
          initialChildren: children,
        );

  static const String name = 'AuthRoute';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.AuthView]
class AuthViewRoute extends _i9.PageRouteInfo<void> {
  const AuthViewRoute()
      : super(
          AuthViewRoute.name,
          path: '',
        );

  static const String name = 'AuthViewRoute';
}

/// generated route for
/// [_i3.HomeView]
class HomeViewRoute extends _i9.PageRouteInfo<void> {
  const HomeViewRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeViewRoute.name,
          path: 'home',
          initialChildren: children,
        );

  static const String name = 'HomeViewRoute';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class TimerRoute extends _i9.PageRouteInfo<void> {
  const TimerRoute({List<_i9.PageRouteInfo>? children})
      : super(
          TimerRoute.name,
          path: 'timer',
          initialChildren: children,
        );

  static const String name = 'TimerRoute';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class BookShelvesRoute extends _i9.PageRouteInfo<void> {
  const BookShelvesRoute({List<_i9.PageRouteInfo>? children})
      : super(
          BookShelvesRoute.name,
          path: 'book_shelves',
          initialChildren: children,
        );

  static const String name = 'BookShelvesRoute';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class QuestBoardRoute extends _i9.PageRouteInfo<void> {
  const QuestBoardRoute({List<_i9.PageRouteInfo>? children})
      : super(
          QuestBoardRoute.name,
          path: 'quest_board',
          initialChildren: children,
        );

  static const String name = 'QuestBoardRoute';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class ProfileRoute extends _i9.PageRouteInfo<void> {
  const ProfileRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          path: 'profile',
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i4.BookShelvesView]
class BookShelvesViewRoute extends _i9.PageRouteInfo<void> {
  const BookShelvesViewRoute()
      : super(
          BookShelvesViewRoute.name,
          path: '',
        );

  static const String name = 'BookShelvesViewRoute';
}

/// generated route for
/// [_i5.BookDetailsView]
class BookDetailsRoute extends _i9.PageRouteInfo<BookDetailsRouteArgs> {
  BookDetailsRoute({
    _i10.Key? key,
    required int bookID,
  }) : super(
          BookDetailsRoute.name,
          path: ':bookID',
          args: BookDetailsRouteArgs(
            key: key,
            bookID: bookID,
          ),
          rawPathParams: {'bookID': bookID},
        );

  static const String name = 'BookDetailsRoute';
}

class BookDetailsRouteArgs {
  const BookDetailsRouteArgs({
    this.key,
    required this.bookID,
  });

  final _i10.Key? key;

  final int bookID;

  @override
  String toString() {
    return 'BookDetailsRouteArgs{key: $key, bookID: $bookID}';
  }
}

/// generated route for
/// [_i6.QuestBoardView]
class QuestBoardViewRoute extends _i9.PageRouteInfo<void> {
  const QuestBoardViewRoute()
      : super(
          QuestBoardViewRoute.name,
          path: '',
        );

  static const String name = 'QuestBoardViewRoute';
}

/// generated route for
/// [_i7.ProfileView]
class ProfileViewRoute extends _i9.PageRouteInfo<void> {
  const ProfileViewRoute()
      : super(
          ProfileViewRoute.name,
          path: '',
        );

  static const String name = 'ProfileViewRoute';
}

/// generated route for
/// [_i8.TimerModeTabBar]
class TimerModeTabBarRoute extends _i9.PageRouteInfo<void> {
  const TimerModeTabBarRoute()
      : super(
          TimerModeTabBarRoute.name,
          path: '',
        );

  static const String name = 'TimerModeTabBarRoute';
}
