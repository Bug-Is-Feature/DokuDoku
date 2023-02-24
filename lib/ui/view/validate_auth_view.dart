import 'package:auto_route/auto_route.dart';
import 'package:dokudoku/provider/navigation_provider.dart';
import 'package:dokudoku/routes/router.gr.dart';
import 'package:dokudoku/theme_app.dart';
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
      child: StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return MaterialApp.router(
            theme: themeData(context),
            debugShowCheckedModeBanner: false,
            routerDelegate: _appRouter.delegate(
                // initialRoutes: [
                // snapshot.hasData ? const HomeRoute() : const AuthRoute() ],
                ),
            routeInformationParser: _appRouter.defaultRouteParser(),

            // routerDelegate: AutoRouterDelegate.declarative(
            //   _appRouter,
            //   routes: (_) => [
            //     if (snapshot.hasData) const HomeRoute() else const AuthRoute()
            //   ],
            // ),
            // routeInformationParser: _appRouter.defaultRouteParser(),
          );
        },
      ),
    );
  }
}
