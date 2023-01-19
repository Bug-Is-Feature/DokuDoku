import 'package:dokudoku/ui/components/button.dart';
import 'package:dokudoku/ui/components/hourglass_session_input.dart';
import 'package:dokudoku/ui/components/stopwatch_timer.dart';
import 'package:dokudoku/ui/view/stopwatch_view.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class TimerModeTabBar extends StatefulWidget {
  const TimerModeTabBar({super.key});

  @override
  State<TimerModeTabBar> createState() => _TimerModeTabBarState();
}

class _TimerModeTabBarState extends State<TimerModeTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.resources.color.colorLightest,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Column(
              children: [
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: context.resources.color.colorWhite,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: context.resources.color.grey,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: context.resources.color.colorDarkest),
                    labelColor: context.resources.color.colorNormal2,
                    unselectedLabelColor: context.resources.color.colorDarkest,
                    tabs: [
                      Tab(
                          child: Text(
                        'Stopwatch',
                        style: TextStyle(fontSize: 22, fontFamily: 'primary'),
                      )),
                      Tab(
                          child: Text(
                        'Hourglass',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'primary',
                        ),
                      )),
                    ],
                    onTap: (value) {
                      setState(() {
                        _tabController.index = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                    child: TabBarView(
                  children: [
                    Center(child: StopwatchView()),
                    Center(child: HourglassSessionInput())
                    // Center(
                    //   child: Text('deee'),
                    // )
                  ],
                  controller: _tabController,
                ))
              ],
            ),
          ),
        ));
  }
}
