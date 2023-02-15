import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class TabBarFilter extends StatefulWidget {
  final Widget bothResultFilter;
  final Widget titleResultFilter;
  final Widget authorResultFilter;

  const TabBarFilter({
    super.key,
    required this.bothResultFilter,
    required this.titleResultFilter,
    required this.authorResultFilter,
  });

  @override
  State<TabBarFilter> createState() => _TabBarFilterState();
}

class _TabBarFilterState extends State<TabBarFilter> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('TabBarFilter'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  color: context.resources.color.greyLighter,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TabBar(
                  labelPadding: EdgeInsets.all(8.0),
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: context.resources.color.greyDark,
                        blurRadius: 4,
                        offset: Offset(3, 1),
                      ),
                    ],
                  ),
                  labelColor: context.resources.color.colorDark,
                  unselectedLabelColor: context.resources.color.colorDark,
                  tabs: const [
                    Tab(text: 'Both'),
                    Tab(text: 'Title'),
                    Tab(text: 'Author'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    widget.bothResultFilter,
                    widget.titleResultFilter,
                    widget.authorResultFilter
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
