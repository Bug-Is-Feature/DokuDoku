import 'package:auto_route/auto_route.dart';
import 'package:dokudoku/provider/timer_provider.dart';
import 'package:dokudoku/ui/components/hourglass_session_input.dart';
import 'package:dokudoku/ui/view/stopwatch_view.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:provider/provider.dart';
import 'package:dokudoku/ui/components/snack_bar_utils.dart';

class TimerModeTabBar extends StatefulWidget {
  final int id;
  final String title;

  const TimerModeTabBar(
      {super.key,
      @PathParam() required this.id,
      @PathParam() required this.title});

  @override
  State<TimerModeTabBar> createState() => _TimerModeTabBarState();
}

class _TimerModeTabBarState extends State<TimerModeTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Map<TimerMode, int> pageIndex = {
    TimerMode.stopwatch: 0,
    TimerMode.hourglass: 1,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerProvider>(context);
    return Scaffold(
      backgroundColor: context.resources.color.colorLightest,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
        child: Container(
          decoration: const BoxDecoration(
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
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: context.resources.color.colorDarkest,
                  ),
                  labelColor: context.resources.color.colorNormal2,
                  unselectedLabelColor: context.resources.color.colorDarkest,
                  tabs: [
                    Tab(
                      child: Row(
                        children: const [
                          Icon(Icons.timer),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Stopwatch',
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'primary',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: const [
                          Icon(Icons.hourglass_bottom),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Hourglass',
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'primary',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onTap: (value) {
                    if (provider.currentMode == TimerMode.stopwatch) {
                      _tabController.index = pageIndex[TimerMode.stopwatch]!;

                      SnackBarUtils.showCustomSnackBar(
                        context: context,
                        backgroundColor: context.resources.color.colorNormal3,
                        content: "You can't switch mode while timer is running",
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Center(
                      child: StopwatchView(
                        id: widget.id,
                        title: widget.title,
                      ),
                    ),
                    Center(
                      child: HourglassSessionInput(
                        id: widget.id,
                        title: widget.title,
                      ),
                    ),
                  ],
                ),
              ),
              WillPopScope(
                child: Container(),
                onWillPop: () async {
                  if (_tabController.index == pageIndex[TimerMode.hourglass]) {
                    _tabController.index = pageIndex[TimerMode.stopwatch]!;
                    return false;
                  } else {
                    return true;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
