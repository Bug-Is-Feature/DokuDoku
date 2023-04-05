import 'package:dokudoku/model/badge.dart' as Badge;
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/services/image_service.dart';
import 'package:dokudoku/ui/components/button.dart';
import 'package:flutter/material.dart';

class BadgeDialog extends StatefulWidget {
  Badge.Badge badge;
  BadgeDialog({super.key, required this.badge});

  @override
  State<BadgeDialog> createState() => _BadgeDialogState();
}

class _BadgeDialogState extends State<BadgeDialog> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot snapShot) {
        return snapShot.connectionState == ConnectionState.waiting
            ? const CircularProgressIndicator()
            : AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                buttonPadding: const EdgeInsets.all(0),
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: context.resources.color.colorWhite,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      color: context.resources.color.colorDark,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
                title: Text(widget.badge.name),
                content: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: context.resources.color.greyDark,
                        blurRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    gradient: LinearGradient(
                      colors: [
                        context.resources.color.colorLighter,
                        context.resources.color.colorLightest,
                      ],
                      stops: const [0.45, 0.45],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.08,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            widget.badge.name,
                            style: TextStyle(
                                fontSize: 28,
                                color: context.resources.color.greyDarker),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.15,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              widget.badge.description,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: context.resources.color.greyDarker),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * -0.18,
                        height: 180,
                        width: 180,
                        child: snapShot.connectionState ==
                                ConnectionState.waiting
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : FutureBuilder(
                                future: ImageService.getImageUrl(
                                    imageRef: widget.badge.unlockedThumbnail),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapShot) {
                                  return (snapShot.connectionState ==
                                          ConnectionState.waiting)
                                      ? const CircularProgressIndicator()
                                      : Image.network(
                                          snapShot.data.toString(),
                                          fit: BoxFit.cover,
                                        );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
