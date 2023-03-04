import 'package:dokudoku/model/book.dart';
import 'package:dokudoku/model/library.dart';
import 'package:dokudoku/model/library_books.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/ui/view/bookshelves_tab_view.dart';
import 'package:flutter/material.dart';

class BookShelvesTabBar extends StatefulWidget {
  Future<Library> library;
  final void Function(bool) libraryBookStatusUpdateCallback;
  final void Function(bool, Book) bookUpdateCallback;
  final void Function(bool, LibraryBooks) libraryBookAddCallback,
      libraryBookRemoveCallback;

  BookShelvesTabBar({
    super.key,
    required this.library,
    required this.libraryBookAddCallback,
    required this.libraryBookRemoveCallback,
    required this.libraryBookStatusUpdateCallback,
    required this.bookUpdateCallback,
  });

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
            child:
                // child: FutureBuilder<Library>(
                //   future: widget.library,
                //   builder: (BuildContext context, AsyncSnapshot<Library> snapshot) {
                //     return snapshot.connectionState == ConnectionState.waiting
                //         ? const Center(child: CircularProgressIndicator())
                TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Center(
                  child: BookshelvesTabView(
                    library: widget.library,
                    type: 'incomplete',
                    libraryBookAddCallback: widget.libraryBookAddCallback,
                    libraryBookRemoveCallback: widget.libraryBookRemoveCallback,
                    libraryBookStatusUpdateCallback:
                        widget.libraryBookStatusUpdateCallback,
                    bookUpdateCallback: widget.bookUpdateCallback,
                  ),
                ),
                Center(
                  child: BookshelvesTabView(
                    library: widget.library,
                    type: 'completed',
                    libraryBookAddCallback: widget.libraryBookAddCallback,
                    libraryBookRemoveCallback: widget.libraryBookRemoveCallback,
                    libraryBookStatusUpdateCallback:
                        widget.libraryBookStatusUpdateCallback,
                    bookUpdateCallback: widget.bookUpdateCallback,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
