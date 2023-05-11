import 'package:auto_route/auto_route.dart';
import 'package:dokudoku/provider/badge_provider.dart';
import 'package:dokudoku/provider/bottomNavbar_provider.dart';
import 'package:dokudoku/provider/navigation_provider.dart';
import 'package:dokudoku/provider/recommend_books_provider.dart';
import 'package:dokudoku/provider/session_provider.dart';
import 'package:dokudoku/provider/user_provider.dart';
import 'package:dokudoku/theme_app.dart';
import 'package:dokudoku/provider/book_provider.dart';
import 'package:dokudoku/provider/timer_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:dokudoku/firebase_options.dart';
import 'package:dokudoku/routes/router.gr.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: '.env');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<TimerProvider>(create: (context) => TimerProvider()),
    ChangeNotifierProvider<BookProvider>(create: (context) => BookProvider()),
    ChangeNotifierProvider<SessionProvider>(
        create: (context) => SessionProvider()),
    ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
    ChangeNotifierProvider<BadgeProvider>(create: (context) => BadgeProvider()),
    ChangeNotifierProvider(create: (context) => RecommendBooksProvider()),
    ChangeNotifierProvider<BottomNavbarProvider>(
        create: (context) => BottomNavbarProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return MaterialApp.router(
            theme: themeData(context),
            debugShowCheckedModeBanner: false,
            routerDelegate: AutoRouterDelegate.declarative(
              _appRouter,
              routes: (_) => [
                if (snapshot.hasData) const HomeRoute() else const AuthRoute(),
              ],
            ),
            routeInformationParser:
                _appRouter.defaultRouteParser(includePrefixMatches: true),
          );
        },
      ),
    );
  }
}
