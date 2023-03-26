import 'package:dokudoku/model/user.dart';
import 'package:dokudoku/provider/user_provider.dart';
import 'package:dokudoku/ui/view/statistic_view.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/services/auth_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dokudoku/routes/router.gr.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    setState(() {
      provider.user = provider.user;
    });
    return Scaffold(
      backgroundColor: context.resources.color.colorLightest,
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 25),
              child: FutureBuilder<Users>(
                  future: provider.user,
                  builder:
                      (BuildContext context, AsyncSnapshot<Users> snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const Center(child: CircularProgressIndicator())
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                size: 100,
                                color: context.resources.color.colorDarkest,
                              ),
                              const SizedBox(
                                width: 35,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Lvl ${snapshot.data!.currentLvl}',
                                    style: const TextStyle(fontSize: 70),
                                  ),
                                  Text(
                                    "${snapshot.data!.currentExp}/1000 EXP",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    height: 5,
                                    child: LinearProgressIndicator(
                                      value: 0.5,
                                      backgroundColor:
                                          context.resources.color.colorWhite,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          context.resources.color.colorDark),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                  })),
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.bar_chart,
                        color: context.resources.color.colorDarkest,
                      ),
                      const SizedBox(width: 30),
                      //   const Text(
                      //     'Statistic',
                      //     style: TextStyle(fontSize: 20),
                      //   ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const StatisticView()));
                        },
                        child: const Text(
                          'Statistic',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: context.resources.color.colorDarkest,
                      ),
                      const SizedBox(width: 30),
                      const Text(
                        'Calendar Month',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: context.resources.color.colorDarkest,
                      ),
                      const SizedBox(width: 30),
                      const Text(
                        'Note History',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.settings,
                        color: context.resources.color.colorDarkest,
                      ),
                      const SizedBox(width: 30),
                      const Text(
                        'Achievement',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.notifications,
                        color: context.resources.color.colorDarkest,
                      ),
                      const SizedBox(width: 30),
                      const Text(
                        'Notification',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            color: context.resources.color.colorDarkest,
            onPressed: () async {
              await AuthService.googleAuth.signOut();
              await AuthService.signOut();
              context.router.replace(const AuthRoute());
            },
          ),
        ],
      ),
    );
  }
}
