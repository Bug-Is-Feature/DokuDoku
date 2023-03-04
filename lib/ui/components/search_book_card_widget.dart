import 'package:dokudoku/model/google_book.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:flutter/material.dart';

class GoogleBookSearchCard extends StatefulWidget {
  final GoogleBook book;
  final double imageHeight;
  final double imageWidth;
  final List<String> idList;
  final void Function(bool) onPressed;
  final VoidCallback onTap;

  const GoogleBookSearchCard({
    super.key,
    required this.book,
    required this.imageHeight,
    required this.imageWidth,
    required this.idList,
    required this.onTap,
    required this.onPressed,
  });

  @override
  State<GoogleBookSearchCard> createState() => _GoogleBookSearchCardState();
}

class _GoogleBookSearchCardState extends State<GoogleBookSearchCard> {
  final String noTitleBookName = 'No Title Recorded';

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => {
          widget.onTap(),
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Image.network(
                    widget.book.volumeInfo.thumbnail,
                    fit: BoxFit.cover,
                    width: widget.imageWidth,
                    height: widget.imageHeight,
                    errorBuilder: ((context, error, stackTrace) =>
                        Image.asset('assets/images/book_cover.png')),
                  ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.book.volumeInfo.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: widget.book.volumeInfo.title ==
                                    noTitleBookName
                                ? const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)
                                : const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.book.volumeInfo.authors.isEmpty
                                ? ''
                                : widget.book.volumeInfo.authors.join(' | '),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            widget.book.volumeInfo.categories.isEmpty
                                ? ''
                                : widget.book.volumeInfo.categories[0],
                            style: const TextStyle(color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.book.volumeInfo.categories.isNotEmpty &&
                                    widget.book.volumeInfo.pageCount != -1
                                ? ' — '
                                : '',
                            style: const TextStyle(color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.book.volumeInfo.pageCount == -1
                                ? ''
                                : '${widget.book.volumeInfo.pageCount} Pages',
                            style: const TextStyle(color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    widget.idList.contains(widget.book.googleBookId)
                        ? widget.onPressed(false)
                        : widget.onPressed(true);
                  },
                  color: context.resources.color.colorDarkest,
                  iconSize: 50,
                  icon: Icon(
                    widget.idList.contains(widget.book.googleBookId)
                        ? Icons.check_circle
                        : Icons.add_circle,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
