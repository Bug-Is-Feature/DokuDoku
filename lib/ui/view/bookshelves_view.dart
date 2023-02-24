import 'dart:async';
import 'dart:ui';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dokudoku/routes/router.gr.dart';
import 'package:dokudoku/ui/components/bookshelves_tabbar.dart';
import 'package:dokudoku/ui/components/incomplete_badge.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/services/auth_service.dart';

class BookShelvesView extends StatefulWidget {
  const BookShelvesView({super.key});

  @override
  State<BookShelvesView> createState() => _BookShelvesViewState();
}

class _BookShelvesViewState extends State<BookShelvesView> {
  List book = [
    Book(id: 0),
    Book(id: 1),
    Book(id: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              color: context.resources.color.colorLighter2,
            ),
            IncompleteStatusBadge(),
          ], alignment: Alignment.center),
          Expanded(
            child: Container(
              color: context.resources.color.colorWhite,
              child: const BookShelvesTabBar(),
            ),
          ),
          Expanded(
            child: Container(
              color: context.resources.color.colorWhite,
              child: ListView(
                children: [
                  for (int i = 0; i < book.length; i++)
                    BooKCard(
                      id: i,
                      onTap: () {
                        context.router.push(
                          BookDetailsRoute(
                            bookID: book[i].id,
                          ),
                        );
                      },
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Book<Widget> {
  final int id;

  Book({required this.id});
}

class BooKCard extends StatelessWidget {
  final int id;
  final GestureTapCallback onTap;
  BooKCard({required this.id, required this.onTap});

  Widget build(BuildContext context) {
    return ListTile(title: Text('Book $id'), onTap: onTap);
  }
}
