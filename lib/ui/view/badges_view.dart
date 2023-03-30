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
  @override
  Widget build(BuildContext context) {
    final badgeProvider = Provider.of<BadgeProvider>(context, listen: false);

    unlockAchievement(context);
    Future<List<UserBadges>> userBadges = getAllUserBadges(context);
    print(userBadges);

    return Scaffold(
      body: FutureBuilder<List<Badge.Badge>>(
        future: badgeProvider.badges,
        builder:
            (BuildContext context, AsyncSnapshot<List<Badge.Badge>> snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final badge = snapshot.data![index];
                    return ListTile(
                      title: Text(badge.name),
                      subtitle: Text(badge.description),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BadgeDialog(badge: badge),
                          ),
                        );
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}

unlockAchievement(BuildContext context) {
  final badgeProvider = Provider.of<BadgeProvider>(context, listen: false);
  final timerProvider = Provider.of<TimerProvider>(context, listen: false);
  final bookProvider = Provider.of<BookProvider>(context, listen: false);

  badgeProvider.badges.then(
    (list) {
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
              print("Unlock achievement : ${list[index].name}");
              print("Unlock achievement id : ${list.indexOf(element) + 1}");

              await BadgeService.unlockBadge(list.indexOf(element) + 1);
            }
          }

          // -- Lord of Tsundoku --I
          if (element.condition == "Incomplete Book Amount") {
            int index = list.indexOf(element);
            bookProvider.library.then((value) {
              print("incomplete books : ${value.incompleteCount}");
              int incompleteBook = value.incompleteCount;
              if (incompleteBook >= list[index].threshold) {
                print("achievement threshold : ${list[index].threshold}");
                print("Unlock achievement : ${list[index].name}");
                print("Unlock achievement id : ${list.indexOf(element) + 1}");

                BadgeService.unlockBadge(list.indexOf(element) + 1);
              }
            });
          }

          // -- Determined Meow --
          if (element.condition == "Hourglass Reading Hours") {
            int index = list.indexOf(element);
            if (timerProvider.sumHourglass >= list[index].threshold) {
              print("achievement threshold : ${list[index].threshold}");
              print("Unlock achievement : ${list[index].name}");
              print("Unlock achievement id : ${list.indexOf(element) + 1}");

              await BadgeService.unlockBadge(list.indexOf(element) + 1);
            }
          }

          // -- Skilled Cat --
          if (element.condition == "Total Reading Hours") {
            int index = list.indexOf(element);
            if (timerProvider.totalReadingDuration >= list[index].threshold) {
              print("achievement threshold : ${list[index].threshold}");
              print("Unlock achievement : ${list[index].name}");
              print("Unlock achievement id : ${list.indexOf(element) + 1}");

              await BadgeService.unlockBadge(list.indexOf(element) + 1);
            }
          }
        },
      );
    },
  );
}

Future<List<UserBadges>> getAllUserBadges(BuildContext context) {
  final badgeProvider = Provider.of<BadgeProvider>(context, listen: false);
  Future<List<UserBadges>> userBadgeList = badgeProvider.userBadges;

  return userBadgeList;
}
