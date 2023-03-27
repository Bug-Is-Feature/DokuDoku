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
  bool isSwitch = true;

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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: context.resources.color.colorLighter2,
                boxShadow: [
                  BoxShadow(
                    color: context.resources.color.grey,
                    blurRadius: 2,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Positioned(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.14,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                const Text(
                                  "LV 2",
                                  style: TextStyle(fontSize: 45),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    const Text(
                                      "200/1000 EXP",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: 200,
                                      height: 10,
                                      child: LinearProgressIndicator(
                                        value: 0.5,
                                        backgroundColor:
                                            context.resources.color.colorWhite,
                                        valueColor: AlwaysStoppedAnimation<
                                                Color>(
                                            context.resources.color.colorDark),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(
                              color: context.resources.color.colorNormal,
                              height: MediaQuery.of(context).size.height * 0.05,
                              thickness: 1,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    //Statistic
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: context
                                              .resources.color.colorWhite),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: context.resources.color
                                                  .colorLighter2,
                                            ),
                                            child: Icon(
                                              Icons.bar_chart,
                                              color: context
                                                  .resources.color.colorDark,
                                              size: 32,
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          const Text(
                                            'Statistic',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    //Weekly Plan
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: context
                                              .resources.color.colorWhite),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: context.resources.color
                                                  .colorLighter2,
                                            ),
                                            child: Icon(
                                              Icons.calendar_today_outlined,
                                              color: context
                                                  .resources.color.colorDark,
                                              size: 30,
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          const Text(
                                            'Weekly Plan',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    //Note History
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: context
                                              .resources.color.colorWhite),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: context.resources.color
                                                  .colorLighter2,
                                            ),
                                            child: Icon(
                                              Icons.history,
                                              color: context
                                                  .resources.color.colorDark,
                                              size: 32,
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          const Text(
                                            'Note History',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: context
                                              .resources.color.colorWhite),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: context.resources.color
                                                  .colorLighter2,
                                            ),
                                            child: Icon(
                                              Icons.stars_rounded,
                                              color: context
                                                  .resources.color.colorDark,
                                              size: 32,
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          const Text(
                                            'Achievement',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    //Notification
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: context
                                              .resources.color.colorWhite),
                                      //Notification Row
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: context.resources.color
                                                  .colorLighter2,
                                            ),
                                            child: Icon(
                                              Icons.notifications_none,
                                              color: context
                                                  .resources.color.colorDark,
                                              size: 32,
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          const Expanded(
                                            child: Text(
                                              'Notification',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Switch(
                                            activeColor: context
                                                .resources.color.colorDark,
                                            value: isSwitch,
                                            onChanged: ((bool newBool) {
                                              setState(() {
                                                isSwitch = newBool;
                                              });
                                            }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: -80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.resources.color.colorLighter2,
                            boxShadow: [
                              BoxShadow(
                                color: context.resources.color.grey,
                                blurRadius: 2,
                                offset: const Offset(0, -2),
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.resources.color.colorLightest,
                            ),
                            child: Icon(
                              Icons.person,
                              size: 100,
                              color: context.resources.color.colorDark,
                            ),
                          ),
                        ),
                      ],
                    ),
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
