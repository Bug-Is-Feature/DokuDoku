import 'package:auto_route/auto_route.dart';
import 'package:dokudoku/provider/navigation_provider.dart';
import 'package:dokudoku/theme_app.dart';
import 'package:dokudoku/services/timer_service.dart';
import 'package:dokudoku/ui/view/validate_auth_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:dokudoku/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dokudoku/routes/router.gr.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: '.env');
  runApp(
    ChangeNotifierProvider<TimerService>(
      create: (_) => TimerService(),
      child: MyApp(),
    ),
  );
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

            // routerDelegate: _appRouter.delegate(
            //   initialRoutes: [
            //     snapshot.hasData ? const HomeRoute() : const AuthRoute(),
            //   ],
            // ),
            // routeInformationParser: _appRouter.defaultRouteParser(),

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
