import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

import 'package:dokudoku/model/quotes.dart';
import 'package:dokudoku/remote/remote_service.dart';

class DialogBox extends StatefulWidget {
  const DialogBox({super.key});

  @override
  _DialogBox createState() => _DialogBox();
}

class _DialogBox extends State<DialogBox> {
  List<String> litems = [];
  final TextEditingController eCtrl = TextEditingController();

  List<String> showText = [];
  List<String> real = [];
  var index = 0;
  List<TextModel>? model;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    model = await RemoteService().getUsers();
    if (model != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void myFunction() {
      showText.add(model![index].q);
      real = showText.reversed.toList();
      index++;
      setState(() {});
    }

    Future.delayed(Duration(seconds: Random().nextInt(10)), () {
      myFunction();
    });
    return Center(
      child: Container(
        width: 323,
        height: 351,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(60),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Scaffold(
            body: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    reverse: true,
                    itemCount: real.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext ctxt, int Index) {
                      return Container(
                        padding: EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green[200],
                              ),
                              padding: EdgeInsets.all(16),
                              child: Text(real[Index])),
                        ),
                      );
                    }))
          ],
        )),
      ),
    );
  }
}
