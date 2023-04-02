import 'package:dokudoku/model/badge.dart' as Badge;
import 'package:dokudoku/model/user_badge.dart';
import 'package:dokudoku/provider/badge_provider.dart';
import 'package:dokudoku/provider/book_provider.dart';
import 'package:dokudoku/provider/timer_provider.dart';
import 'package:dokudoku/services/badge_service.dart';
import 'package:dokudoku/ui/components/badge_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BadgesView extends StatefulWidget {
  const BadgesView({super.key});

  @override
  State<BadgesView> createState() => BadgesViewState();
}

class BadgesViewState extends State<BadgesView> {
  bool isUnlock = true;
  bool isLoading = true;
  List<int> userBadgesId = [];
  @override
  void initState() {
    super.initState();
    final badgeProvider = Provider.of<BadgeProvider>(context, listen: false);

    unlockAchievement(context).whenComplete(() {
      setState(() {
        isUnlock = false;
      });
      badgeProvider.getAllUserBadges().then(
            (value) => setState(
              () {
                for (var i = 0; i < value.length; i++) {
                  userBadgesId.add(value[i].unlockedAchievementId);
                  print(
                      "badges : ----------- ---- ${value[i].unlockedAchievementId}");
                }
                isLoading = false;
              },
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final badgeProvider = Provider.of<BadgeProvider>(context, listen: false);

    if (isUnlock || isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return FutureBuilder<List<Badge.Badge>>(
        future: badgeProvider.badges,
        builder: (BuildContext context,
            AsyncSnapshot<List<Badge.Badge>> badgeSnapshot) {
          return badgeSnapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: badgeSnapshot.data!.length,
                  itemBuilder: (context, index) {
                    final badge = badgeSnapshot.data![index];
                    //  print(index);

                    if (userBadgesId.contains(index + 1)) {
                      print("true ${badge.name}");
                      return ListTile(
                        title: Text(badge.name),
                        subtitle: Text(
                          "Unlock",
                          style: TextStyle(color: Colors.green),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BadgeDialog(badge: badge),
                            ),
                          );
                        },
                      );
                    } else {
                      print("false ${badge.name}");
                      return ListTile(
                        title: Text(badge.name),
                        subtitle: const Text("Lock"),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BadgeDialog(badge: badge),
                            ),
                          );
                        },
                      );
                    }
                  },
                );
        },
      );

      // FutureBuilder<List<UserBadges>>(
      //   future: badgeProvider.userBadges,
      //   builder: (BuildContext context,
      //       AsyncSnapshot<List<UserBadges>> userBadgesSnapshot) {
      //     final userAllBadges = userBadgesSnapshot.data!;

      //     // list of id badges of user
      //     List<int> userBadgesId =
      //         userAllBadges.map((e) => e.unlockedAchievementId).toList();
      //     print("userBadgesId : $userBadgesId");

      //     return userBadgesSnapshot.connectionState == ConnectionState.waiting
      //         ? const Center(
      //             child: CircularProgressIndicator(),
      //           )
      //         : FutureBuilder<List<Badge.Badge>>(
      //             future: badgeProvider.badges,
      //             builder: (BuildContext context,
      //                 AsyncSnapshot<List<Badge.Badge>> badgeSnapshot) {
      //               return ListView.builder(
      //                 itemCount: badgeSnapshot.data!.length,
      //                 itemBuilder: (context, index) {
      //                   final badge = badgeSnapshot.data![index];
      //                   //  print(index);

      //                   if (userBadgesId.contains(index + 1)) {
      //                     print("true ${badge.name}");
      //                     return ListTile(
      //                       title: Text(badge.name),
      //                       subtitle: Text(
      //                         "Unlock",
      //                         style: TextStyle(color: Colors.green),
      //                       ),
      //                       onTap: () {
      //                         Navigator.of(context).push(
      //                           MaterialPageRoute(
      //                             builder: (context) =>
      //                                 BadgeDialog(badge: badge),
      //                           ),
      //                         );
      //                       },
      //                     );
      //                   } else {
      //                     print("false ${badge.name}");
      //                     return ListTile(
      //                       title: Text(badge.name),
      //                       subtitle: const Text("Lock"),
      //                       onTap: () {
      //                         Navigator.of(context).push(
      //                           MaterialPageRoute(
      //                             builder: (context) =>
      //                                 BadgeDialog(badge: badge),
      //                           ),
      //                         );
      //                       },
      //                     );
      //                   }
      //                 },
      //               );
      //             },
      //           );
      //   },
      // );
    }
  }
}

unlockAchievement(BuildContext context) async {
  final badgeProvider = Provider.of<BadgeProvider>(context, listen: false);
  final timerProvider = Provider.of<TimerProvider>(context, listen: false);
  final bookProvider = Provider.of<BookProvider>(context, listen: false);

  final list = await badgeProvider.badges;
  print("sumSTP : ${timerProvider.sumStopWatch}");
  print("sumH : ${timerProvider.sumHourglass}");
  print("totalDuration : ${timerProvider.totalReadingDuration}");
  list.forEach(
    (element) async {
      // -- Meow's training --
      if (element.condition == "Stopwatch Reading Hours") {
        int index = list.indexOf(element);
        if (timerProvider.sumStopWatch >= list[index].threshold) {
          print("achievement threshold : ${list[index].threshold}");
          print(
              "Unlock achievement : ${list[index].name}, id : ${list.indexOf(element) + 1}");

          await BadgeService.unlockBadge(list.indexOf(element) + 1);
        }
      }

      // -- Lord of Tsundoku --I
      if (element.condition == "Incomplete Book Amount") {
        int index = list.indexOf(element);
        final value = await bookProvider.library;
        print("incomplete books : ${value.incompleteCount}");
        int incompleteBook = value.incompleteCount;
        if (incompleteBook >= list[index].threshold) {
          print("achievement threshold : ${list[index].threshold}");
          print(
              "Unlock achievement : ${list[index].name}, id : ${list.indexOf(element) + 1}");

          await BadgeService.unlockBadge(list.indexOf(element) + 1);
        }

        // -- Determined Meow --
        if (element.condition == "Hourglass Reading Hours") {
          int index = list.indexOf(element);
          if (timerProvider.sumHourglass >= list[index].threshold) {
            print("achievement threshold : ${list[index].threshold}");
            print(
                "Unlock achievement : ${list[index].name} , id : ${list.indexOf(element) + 1}");

            await BadgeService.unlockBadge(list.indexOf(element) + 1);
          }
        }

        // -- Skilled Cat --
        if (element.condition == "Total Reading Hours") {
          int index = list.indexOf(element);
          if (timerProvider.totalReadingDuration >= list[index].threshold) {
            print("achievement threshold : ${list[index].threshold}");
            print(
                "Unlock achievement : ${list[index].name}, id : ${list.indexOf(element) + 1}");

            await BadgeService.unlockBadge(list.indexOf(element) + 1);
          }
        }
      }
    },
  );
}

Future<List<int>> getUserBadges(BuildContext context) async {
  final badgeProvider = Provider.of<BadgeProvider>(context, listen: false);
  List<int> userBadgesID = [];
  Future<List<UserBadges>> userBadges = badgeProvider.getAllUserBadges();
  await userBadges.then((value) {
    userBadgesID = value.map((e) => e.unlockedAchievementId).toList();
  }).whenComplete(() => print("userBadgesID : $userBadgesID"));

  return userBadgesID;
}
