// import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/provider/navigation_provider.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/ui/components/bottom_navbar.dart';
import 'package:dokudoku/ui/components/hourglass_session_input.dart';
import 'package:dokudoku/ui/components/navigation_drawer.dart';
import 'package:dokudoku/ui/components/quest_card.dart';
import 'package:dokudoku/ui/components/timer_mode_tabbar.dart';
import 'package:dokudoku/ui/view/auth_view.dart';
import 'package:dokudoku/ui/view/home_view.dart';
import 'package:dokudoku/ui/view/hourglass_view.dart';
import 'package:dokudoku/ui/view/quest_board_view.dart';
import 'package:dokudoku/ui/view/stopwatch_view.dart';
import 'package:dokudoku/services/timer_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(ChangeNotifierProvider<TimerService>(
    create: (_) => TimerService(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: MaterialApp(
          title: 'Dokudoku',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme(
                primary: context.resources.color.colorDarkest,
                onPrimary: context.resources.color.colorWhite,
                brightness: Brightness.light,
                secondary: context.resources.color.colorDark,
                onSecondary: context.resources.color.colorWhite,
                background: context.resources.color.colorLightest,
                error: context.resources.color.warning,
                onBackground: context.resources.color.colorDarkest,
                onError: context.resources.color.colorWhite,
                onSurface: context.resources.color.colorNormal2,
                surface: context.resources.color.colorWhite),
            textTheme: TextTheme(
              headlineLarge: TextStyle(
                fontSize: 50,
                fontFamily: 'primary',
                fontWeight: FontWeight.bold,
                color: context.resources.color.colorDarkest,
              ),
              headline1: TextStyle(
                fontSize: 30,
                fontFamily: 'primary',
                fontWeight: FontWeight.bold,
                color: context.resources.color.colorDarkest,
              ),
              headline2: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'primary',
                  color: context.resources.color.colorDarkest),
              subtitle1: TextStyle(
                  fontSize: 20,
                  fontFamily: 'primary',
                  color: context.resources.color.colorDarkest),
              bodyText1: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'primary',
                  color: context.resources.color.colorDarkest),
              bodyText2: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'primary',
                  color: context.resources.color.colorDarkest),
              labelMedium: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'primary',
                  color: context.resources.color.colorDarkest),
            ),
          ),
          home: QuestBoardView()
          //AuthView(),
          //
          //HourglassView()
          //
          //TimerModeTabBar() //

          //
          ),
    );

    // bottomNavigationBar: BottomNavBar(),
  }
}
