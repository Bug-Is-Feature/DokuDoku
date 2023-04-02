import 'package:dokudoku/provider/bottomNavbar_provider.dart';
import 'package:dokudoku/ui/components/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/services/auth_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dokudoku/routes/router.gr.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
//   final int id;
//   final String title;

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: AutoTabsScaffold(
          extendBodyBehindAppBar: true,
          routes: const [
            BookShelvesRoute(),
            BadgeRoute(),
            ProfileRoute(),
          ],
          bottomNavigationBuilder: ((context, tabsRouter) {
            return Consumer<BottomNavbarProvider>(
              builder: (context, BottomNavbarProvider, _) {
                return BottomNavigationBar(
                  backgroundColor: context.resources.color.colorDarkest,
                  items: BottomNavBar.listItemBottomBar,
                  currentIndex: BottomNavbarProvider.currentIndex,
                  onTap: (index) {
                    BottomNavbarProvider.setIndex(index);
                    tabsRouter.setActiveIndex(index);
                    print(
                        "bottom navbar index : ${BottomNavbarProvider.currentIndex}");
                  },
                  elevation: BottomNavBar.elevation,
                  showSelectedLabels: BottomNavBar.showSelectedLabels,
                  showUnselectedLabels: BottomNavBar.showUnselectedLabels,
                  type: BottomNavBar.bottomNavigationBarType,
                  selectedItemColor: BottomNavBar.selectedItemColor,
                  unselectedItemColor: BottomNavBar.unSelectedItemColor,
                );
              },
            );
          })

          // BottomNavigationBar(
          //   backgroundColor: context.resources.color.colorDarkest,
          //   items: BottomNavBar.listItemBottomBar,
          //   currentIndex: tabsRouter.activeIndex,
          //   onTap: tabsRouter.setActiveIndex,
          //   elevation: BottomNavBar.elevation,
          //   showSelectedLabels: BottomNavBar.showSelectedLabels,
          //   showUnselectedLabels: BottomNavBar.showUnselectedLabels,
          //   type: BottomNavBar.bottomNavigationBarType,
          //   selectedItemColor: BottomNavBar.selectedItemColor,
          //   unselectedItemColor: BottomNavBar.unSelectedItemColor,
          // ),
          ),
    );
    // return Scaffold(
    //   extendBodyBehindAppBar: true,
    //   body: AutoTabsScaffold(
    //     extendBodyBehindAppBar: true,
    //     routes: const [
    //       BookShelvesRoute(),
    //       QuestBoardRoute(),
    //       ProfileRoute(),
    //     ],
    //     bottomNavigationBuilder: (context, tabsRouter) => BottomNavigationBar(
    //       backgroundColor: context.resources.color.colorDarkest,
    //       items: BottomNavBar.listItemBottomBar,
    //       currentIndex: tabsRouter.activeIndex,
    //       onTap: tabsRouter.setActiveIndex,
    //       elevation: BottomNavBar.elevation,
    //       showSelectedLabels: BottomNavBar.showSelectedLabels,
    //       showUnselectedLabels: BottomNavBar.showUnselectedLabels,
    //       type: BottomNavBar.bottomNavigationBarType,
    //       selectedItemColor: BottomNavBar.selectedItemColor,
    //       unselectedItemColor: BottomNavBar.unSelectedItemColor,
    //     ),
    //   ),
    // );
  }
}
