import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:flutter/material.dart';

class AuthorCard extends StatefulWidget {
  String authorName;
  AuthorCard({super.key, required this.authorName});

  @override
  State<AuthorCard> createState() => _AuthorCardState();
}

class _AuthorCardState extends State<AuthorCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.15,
        decoration: BoxDecoration(
          color: context.resources.color.colorWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: context.resources.color.grey,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.authorName}',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              IconButton(
                onPressed: () {
                  //   showDialog(
                  //     context: context,
                  //     builder: (context) => AlertDialog(
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //       content: TextField(
                  //         decoration: InputDecoration(
                  //           labelText: 'Author name',
                  //           border: OutlineInputBorder(
                  //               borderRadius:
                  //                   BorderRadius.all(Radius.circular(20))),
                  //         ),
                  //       ),
                  //       actions: [
                  //         TextButton(
                  //           onPressed: () {
                  //             Navigator.of(context).pop();
                  //           },
                  //           child: Text('Delete'),
                  //         ),
                  //         TextButton(
                  //           onPressed: () {
                  //             Navigator.of(context).pop();
                  //           },
                  //           child: Text('Save'),
                  //         ),
                  //       ],
                  //     ),
                  //   );
                },
                icon: Icon(
                  Icons.edit,
                  size: 24,
                  color: context.resources.color.colorDarkest,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
