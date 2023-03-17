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
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: context.resources.color.colorDarkest,
                  ),
                  child: Icon(
                    Icons.person,
                    size: 100,
                    color: context.resources.color.colorWhite,
                  ),
                ),
                Column(
                  children: [
                    const Text(
                      "LV 2",
                      style: TextStyle(fontSize: 70),
                    ),
                    const Text(
                      "200/1000 EXP",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 100,
                      height: 5,
                      child: LinearProgressIndicator(
                        value: 0.5,
                        backgroundColor: context.resources.color.colorWhite,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            context.resources.color.colorDark),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: context.resources.color.colorLighter),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Row(
                        children: [
                          Icon(
                            Icons.bar_chart,
                            color: context.resources.color.colorDarkest,
                            size: 30,
                          ),
                          const SizedBox(width: 30),
                          const Text(
                            'Statistic',
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: context.resources.color.colorDarkest,
                            size: 30,
                          ),
                          const SizedBox(width: 30),
                          const Text(
                            'Calendar Month',
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Row(
                        children: [
                          Icon(
                            Icons.history,
                            color: context.resources.color.colorDarkest,
                            size: 30,
                          ),
                          const SizedBox(width: 30),
                          const Text(
                            'Note History',
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.settings,
                            color: context.resources.color.colorDarkest,
                            size: 30,
                          ),
                          const SizedBox(width: 30),
                          const Text(
                            'Achievement',
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Row(
                        children: [
                          Icon(
                            Icons.notifications,
                            color: context.resources.color.colorDarkest,
                            size: 30,
                          ),
                          const SizedBox(width: 30),
                          const Text(
                            'Notification',
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await AuthService.googleAuth.signOut();
                              await AuthService.signOut();
                              context.router.replace(const AuthRoute());
                            },
                            child: Icon(
                              (Icons.logout),
                              color: context.resources.color.colorDarkest,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
