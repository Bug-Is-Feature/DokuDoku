import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class TabBarFilterStatistic extends StatefulWidget {
  // final Widget dayResultFilter;
  // final Widget weekResultFilter;
  // final Widget monthResultFilter;
  // final Widget yearResultFilter;

  const TabBarFilterStatistic({
    super.key,
    // required this.dayResultFilter,
    // required this.weekResultFilter,
    // required this.monthResultFilter,
    // required this.yearResultFilter,
  });

  @override
  State<TabBarFilterStatistic> createState() => _TabBarFilterStatisticState();
}

class _TabBarFilterStatisticState extends State<TabBarFilterStatistic> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                color: context.resources.color.colorDarkest,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: context.resources.color.greyDark,
                      blurRadius: 4,
                      offset: const Offset(3, 1),
                    ),
                  ],
                ),
                labelColor: context.resources.color.colorDarkest,
                unselectedLabelColor: context.resources.color.colorLighter,
                tabs: const [
                  Tab(text: "Day"),
                  Tab(text: 'Week'),
                  Tab(text: 'Month'),
                  Tab(text: 'Year'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Tab(text: "Day"),
                  Tab(text: 'Week'),
                  Tab(text: 'Month'),
                  Tab(text: 'Year'),
                  // widget.dayResultFilter,
                  // widget.weekResultFilter,
                  // widget.monthResultFilter,
                  // widget.yearResultFilter,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
