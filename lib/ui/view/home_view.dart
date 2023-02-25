import 'package:dokudoku/ui/components/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/services/auth_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dokudoku/routes/router.gr.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: AutoTabsScaffold(
        extendBodyBehindAppBar: true,
        // appBarBuilder: (context, tabsRouter) => AppBar(
        //   elevation: 0,
        //   backgroundColor: Colors.transparent,
        //   centerTitle: true,
        //   leading: const AutoBackButton(),
        //   actions: [
        //     IconButton(
        //       icon: const Icon(Icons.logout),
        //       color: context.resources.color.colorDarkest,
        //       onPressed: () async {
        //         await AuthService.googleAuth.signOut();
        //         await AuthService.signOut();
        //         context.router.replace(const AuthRoute());
        //       },
        //     ),
        //   ],
        // ),
        routes: const [
          BookShelvesRoute(),
          QuestBoardRoute(),
          ProfileRoute(),
        ],
        bottomNavigationBuilder: (context, tabsRouter) => BottomNavigationBar(
          backgroundColor: context.resources.color.colorDarkest,
          items: BottomNavBar.listItemBottomBar,
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          elevation: BottomNavBar.elevation,
          showSelectedLabels: BottomNavBar.showSelectedLabels,
          showUnselectedLabels: BottomNavBar.showUnselectedLabels,
          type: BottomNavBar.bottomNavigationBarType,
          selectedItemColor: BottomNavBar.selectedItemColor,
          unselectedItemColor: BottomNavBar.unSelectedItemColor,
        ),
      ),
    );
  }
}
