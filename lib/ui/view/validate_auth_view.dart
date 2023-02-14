import 'package:auto_route/auto_route.dart';
import 'package:dokudoku/provider/navigation_provider.dart';
import 'package:dokudoku/routes/router.gr.dart';
import 'package:dokudoku/theme_app.dart';
import 'package:dokudoku/ui/view/auth_view.dart';
import 'package:dokudoku/ui/view/bookshelves_view.dart';
import 'package:dokudoku/ui/view/home_view.dart';
import 'package:dokudoku/ui/view/stopwatch_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ValidateAuthView extends StatefulWidget {
  const ValidateAuthView({super.key});

  @override
  State<ValidateAuthView> createState() => _ValidateAuthViewState();
}

class _ValidateAuthViewState extends State<ValidateAuthView> {
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              return MaterialApp.router(
                theme: themeData(context),
                debugShowCheckedModeBanner: false,
                routerDelegate: AutoRouterDelegate.declarative(
                  _appRouter,
                  routes: (_) => [const HomeRoute()],
                ),
              );
            } else {
              return MaterialApp.router(
                theme: themeData(context),
                debugShowCheckedModeBanner: false,
                routerDelegate: AutoRouterDelegate.declarative(
                  _appRouter,
                  routes: (_) => [const AuthRoute()],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
