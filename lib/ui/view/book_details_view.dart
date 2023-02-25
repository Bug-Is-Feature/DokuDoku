import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class BookDetailsView extends StatelessWidget {
  final int bookID;
  const BookDetailsView({super.key, @PathParam() required this.bookID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.red,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.05,
                  color: Colors.blue,
                ),
                Text(
                  "ddddddd",
                  style: TextStyle(color: Colors.white, fontSize: 64),
                ),
              ],
            ),
          ),
          Container()
        ],
      ),
    );
  }
}
