import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:dokudoku/ui/components/timer_mode_tabbar.dart';
import 'package:dokudoku/ui/view/auth_view.dart';
import 'package:dokudoku/ui/view/book_details_view.dart';
import 'package:dokudoku/ui/view/bookshelves_view.dart';
import 'package:dokudoku/ui/view/home_view.dart';
import 'package:dokudoku/ui/view/hourglass_view.dart';
import 'package:dokudoku/ui/view/profile_view.dart';
import 'package:dokudoku/ui/view/badges_view.dart';
import 'package:flutter/material.dart';

@MaterialAutoRouter(
  routes: [
    AutoRoute(
      path: '/auth',
      name: 'AuthRoute',
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: '', page: AuthView),
      ],
    ),
    AutoRoute(
      path: '/',
      name: 'HomeRoute',
      page: EmptyRouterPage,
      children: [
        AutoRoute(
          path: 'home',
          initial: true,
          page: HomeView,
          children: [
            AutoRoute(
              path: 'book_shelves',
              name: 'BookShelvesRoute',
              page: EmptyRouterPage,
              children: [
                AutoRoute(path: '', page: BookShelvesView),
                AutoRoute(name: 'BookDetailsRoute', page: BookDetailsView),
              ],
            ),
            AutoRoute(
              path: 'badge',
              name: 'BadgeRoute',
              page: EmptyRouterPage,
              maintainState: false,
              children: [
                AutoRoute(path: '', page: BadgesView),
              ],
            ),
            AutoRoute(
              path: 'profile',
              name: 'profileRoute',
              page: EmptyRouterPage,
              children: [
                AutoRoute(path: '', page: ProfileView),
              ],
            ),
          ],
        ),
        AutoRoute(
          path: 'timer',
          name: 'TimerRoute',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
                path: ':id/:title',
                initial: true,
                name: "TimerModeTabBarRoute",
                page: TimerModeTabBar),
            AutoRoute(
                path: ':id/:title/hourglass_view',
                name: "HourglassRoute",
                page: HourglassView),
          ],
        ),
      ],
    ),
  ],
)
class $AppRouter {}
