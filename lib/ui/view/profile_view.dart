import 'dart:math';

import 'package:dokudoku/model/book.dart';
import 'package:dokudoku/model/sessions.dart';
import 'package:dokudoku/model/user.dart';
import 'package:dokudoku/provider/session_provider.dart';
import 'package:dokudoku/provider/user_provider.dart';
import 'package:dokudoku/services/image_service.dart';
import 'package:dokudoku/ui/components/time_distribution_chart.dart';
import 'package:dokudoku/ui/view/recommend_books_view.dart';
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
  const ProfileView({
    super.key,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isSwitch = true;

//   levelUp() async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     final sessionProvider =
//         Provider.of<SessionProvider>(context, listen: false);
//     int level = await userProvider.user.then((value) => value.currentLvl);
//   }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    final sessionProvider =
        Provider.of<SessionProvider>(context, listen: false);
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
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Container(
              decoration: BoxDecoration(
                color: context.resources.color.colorLighter2,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.18,
              child: const RiveAnimation.asset(
                  'assets/images/profile_cat_primaryLight.riv'),
            ),

            Container(
              decoration: BoxDecoration(
                color: context.resources.color.colorLighter2,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  FutureBuilder<Users>(
                      future: userProvider.user,
                      builder: (BuildContext context,
                          AsyncSnapshot<Users> userSnapshot) {
                        // int levelUp() {
                        //   if (userSnapshot.data!.currentExp == 20) {
                        //     return userSnapshot.data!.currentLvl + 1;
                        //   } else {
                        //     return userSnapshot.data!.currentLvl;
                        //   }
                        // }

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "LV ${userSnapshot.data!.currentExp == 10 ? userSnapshot.data!.currentLvl + 1 : userSnapshot.data!.currentLvl}",
                              style: const TextStyle(fontSize: 40),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: LinearProgressIndicator(
                                      value: (userSnapshot.data!.currentExp /
                                              (pow(
                                                          userSnapshot.data!
                                                                  .currentLvl -
                                                              1,
                                                          2) ~/
                                                      5 +
                                                  100))
                                          .toDouble()),
                                ),
                                Text(
                                  "${userSnapshot.data!.currentExp}/${pow(userSnapshot.data!.currentLvl - 1, 2) ~/ 5 + 100}",
                                  style: const TextStyle(fontSize: 18),
                                )
                              ],
                            )
                          ],
                        );
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [],
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
            //Show Recommended Books

            Container(
              color: context.resources.color.colorLighter2,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    "Maybe you read next",
                    style: TextStyle(
                        fontFamily: 'primary',
                        color: context.resources.color.colorDark,
                        fontSize: 30),
                  ),
                  RecommendBooksView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
