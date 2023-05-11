import 'package:dokudoku/provider/recommend_books_provider.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/routes/router.gr.dart';
import 'package:dokudoku/services/image_service.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:dokudoku/model/book.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dokudoku/routes/router.gr.dart';

class RecommendBooksView extends StatefulWidget {
  const RecommendBooksView({super.key});

  @override
  State<RecommendBooksView> createState() => _RecommendBooksViewState();
}

class _RecommendBooksViewState extends State<RecommendBooksView> {
  @override
  Widget build(BuildContext context) {
    final recommendBooksProvider = Provider.of<RecommendBooksProvider>(context);

    return FutureBuilder<List<Book>>(
      future: recommendBooksProvider.recommendBooks,
      builder: (BuildContext context, AsyncSnapshot<List<Book>> bookSnapshot) {
        return bookSnapshot.connectionState == ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: bookSnapshot.data!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      Card(
                        color: context.resources.color.colorWhite,
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60 * 1.6,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: context.resources.color.greyDark,
                                    offset: const Offset(
                                      1.0,
                                      1.0,
                                    ),
                                    blurRadius: 5.0,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: FutureBuilder(
                                future: ImageService.getImageUrl(
                                    imageRef:
                                        bookSnapshot.data![index].thumbnail),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapShot) {
                                  return snapShot.connectionState ==
                                          ConnectionState.waiting
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Image.network(
                                          fit: BoxFit.cover,
                                          snapShot.data.toString(),
                                          errorBuilder:
                                              ((context, error, stackTrace) =>
                                                  Image.asset(
                                                    'assets/images/book_cover.png',
                                                    fit: BoxFit.cover,
                                                  )),
                                        );
                                },
                              ),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Column(
                                children: [
                                  Text(
                                    bookSnapshot.data![index].title,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      context.resources.color.colorDark,
                                  child: Center(
                                    child: IconButton(
                                      iconSize: 30,
                                      icon: Icon(
                                        Icons.timer_outlined,
                                        color:
                                            context.resources.color.colorWhite,
                                      ),
                                      onPressed: () {
                                        context.navigateTo(
                                          TimerRoute(
                                            children: [
                                              TimerModeTabBarRoute(
                                                  id: bookSnapshot
                                                      .data![index].id,
                                                  title: bookSnapshot
                                                      .data![index].title)
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
      },
    );
  }
}
