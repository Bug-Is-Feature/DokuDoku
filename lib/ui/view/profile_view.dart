import 'package:dokudoku/model/sessions.dart';
import 'package:dokudoku/model/user.dart';
import 'package:dokudoku/provider/session_provider.dart';
import 'package:dokudoku/provider/user_provider.dart';
import 'package:dokudoku/ui/components/time_distribution_chart.dart';
import 'package:dokudoku/ui/view/statistic_view.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/services/auth_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dokudoku/routes/router.gr.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
    final sessionProvider = Provider.of<SessionProvider>(context);

    setState(() {
      provider.user = provider.user;
    });
    return Scaffold(
      backgroundColor: context.resources.color.colorLightest,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: AppBar(
            centerTitle: true,
            title: Text(
              "Profile",
              style: TextStyle(
                  fontFamily: 'primary',
                  color: context.resources.color.colorWhite,
                  fontSize: 30),
            ),
            backgroundColor: context.resources.color.colorDark,
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                color: context.resources.color.colorWhite,
                onPressed: () async {
                  await AuthService.googleAuth.signOut();
                  await AuthService.signOut();
                  context.router.replace(const AuthRoute());
                },
              ),
            ]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Container(
              decoration: BoxDecoration(
                color: context.resources.color.colorLighter2,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.18,
              child: RiveAnimation.asset(
                  'assets/images/profile_cat_primaryLight.riv'),
            ),
            Container(
              decoration: BoxDecoration(
                color: context.resources.color.colorLighter2,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Notification
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: context.resources.color.colorWhite),
                                //Notification Row
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: context
                                            .resources.color.colorLighter2,
                                      ),
                                      child: Icon(
                                        Icons.notifications_none,
                                        color:
                                            context.resources.color.colorDark,
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
                                      activeColor:
                                          context.resources.color.colorDark,
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
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Positioned(
                    top: 300,
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.resources.color.colorWhite,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      width: 360,
                      height: 360,
                      child: Positioned(
                        top: 350,
                        child: TimeDistributionChart(
                          session: sessionProvider.session,
                          sessionUpdateCallback: (Future<List<Session>>
                                  session) =>
                              setState(() => sessionProvider.session = session),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
