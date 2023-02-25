import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/ui/view/complete_shelf_view.dart';
import 'package:dokudoku/ui/view/incomplete_shelf_view.dart';
import 'package:flutter/material.dart';

class BookShelvesTabBar extends StatefulWidget {
  const BookShelvesTabBar({super.key});

  @override
  State<BookShelvesTabBar> createState() => _BookShelvesTabBarState();
}

class _BookShelvesTabBarState extends State<BookShelvesTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: context.resources.color.colorLightest,
              boxShadow: [
                BoxShadow(
                  color: context.resources.color.grey,
                  blurRadius: 5,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TabBar(
              indicatorWeight: 4,
              controller: _tabController,
              indicatorColor: context.resources.color.colorDarkest,
              labelColor: context.resources.color.colorDarkest,
              unselectedLabelColor: context.resources.color.colorNormal2,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Incomplete',
                        style: TextStyle(fontSize: 22, fontFamily: 'primary'),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Complete',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'primary',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              onTap: (value) {},
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                Center(
                  child: IncompleteShelfView(),
                ),
                Center(
                  child: CompleteShelfView(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
