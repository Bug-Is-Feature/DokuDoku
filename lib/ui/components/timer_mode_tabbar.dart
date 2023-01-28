import 'package:dokudoku/services/timer_service.dart';
import 'package:dokudoku/ui/components/hourglass_session_input.dart';
import 'package:dokudoku/ui/view/stopwatch_view.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:provider/provider.dart';

class TimerModeTabBar extends StatefulWidget {
  const TimerModeTabBar({super.key});

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
    final provider = Provider.of<TimerService>(context);
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
                      color: context.resources.color.colorDarkest),
                  labelColor: context.resources.color.colorNormal2,
                  unselectedLabelColor: context.resources.color.colorDarkest,
                  tabs: const [
                    Tab(
                      child: Text(
                        'Stopwatch',
                        style: TextStyle(fontSize: 22, fontFamily: 'primary'),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Hourglass',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'primary',
                        ),
                      ),
                    ),
                  ],
                  onTap: (value) {
                    if (provider.currentMode == TimerMode.stopwatch) {
                      _tabController.index = pageIndex[TimerMode.stopwatch]!;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "You can't switch mode while timer is running",
                            style: TextStyle(
                              color: Color(0xff92603D),
                              fontFamily: 'primary',
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  children: const [
                    Center(
                      child: StopwatchView(),
                    ),
                    Center(
                      child: HourglassSessionInput(),
                    )
                  ],
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
