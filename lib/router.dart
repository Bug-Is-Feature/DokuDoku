import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:dokudoku/ui/view/home_view.dart';
import 'package:dokudoku/ui/view/profile_view.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(path: '/', page: HomeView, children: [
      AutoRoute(path: 'profile', page: EmptyRouterPage, children: [
        AutoRoute(path: 'profile', page: ProfileView),
      ]),
    ])
  ],
)
class $AppRouter {}

//Single 