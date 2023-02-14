import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:dokudoku/ui/view/auth_view.dart';
import 'package:dokudoku/ui/view/bookshelves_view.dart';
import 'package:dokudoku/ui/view/home_view.dart';
import 'package:dokudoku/ui/view/note_history_view.dart';
import 'package:dokudoku/ui/view/profile_view.dart';
import 'package:dokudoku/ui/view/quest_board_view.dart';
import 'package:dokudoku/ui/view/validate_auth_view.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      path: '/',
      name: 'ValidateAuthRoute',
      initial: true,
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: '', page: ValidateAuthView),
      ],
    ),
    AutoRoute(
      path: '/auth',
      name: 'AuthRoute',
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: '', page: AuthView),
      ],
    ),
    AutoRoute(
      path: '/user',
      name: 'HomeRoute',
      page: HomeView,
      children: [
        AutoRoute(
          path: 'home',
          name: 'BookShelvesRoute',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: BookShelvesView),
          ],
        ),
        AutoRoute(
          path: 'questBoard',
          name: 'QuestBoardRoute',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: QuestBoardView),
          ],
        ),
        AutoRoute(
          path: 'profile',
          name: 'profileRoute',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: ProfileView),
          ],
        )
      ],
    )
  ],
)
class $AppRouter {}
