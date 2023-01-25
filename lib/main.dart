import 'package:dokudoku/provider/navigation_provider.dart';
import 'package:dokudoku/theme_app.dart';
import 'package:dokudoku/ui/view/auth_view.dart';
import 'package:dokudoku/ui/view/home_view.dart';
import 'package:dokudoku/services/timer_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:dokudoku/submitscreen.dart';
import 'package:dokudoku/timeservice.dart';

void main(List<String> args) {
  runApp(
    ChangeNotifierProvider<TimerService>(
      create: (_) => TimerService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: MaterialApp(
        title: 'Dokudoku',
        debugShowCheckedModeBanner: false,
        theme: themeData(context),
        home: AuthView(),
        // const HomeView(),
      ),
    );
  }
}
