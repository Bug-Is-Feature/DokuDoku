import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.resources.color.colorLightest,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Row(
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
                      const Text(
                        'Statistic',
                        style: TextStyle(fontSize: 20),
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
        ],
      ),
    );
  }
}
