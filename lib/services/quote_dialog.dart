import 'package:dokudoku/services/timer_service.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/model/quotes.dart';
import 'package:dokudoku/remote/remote_service.dart';
import 'package:provider/provider.dart';

class QuoteDialog extends StatefulWidget {
  const QuoteDialog({super.key});

  @override
  _QuoteDialog createState() => _QuoteDialog();
}

class _QuoteDialog extends State<QuoteDialog> {
  List<String> litems = [];
  final TextEditingController eCtrl = TextEditingController();

  List<String> showText = [];
  var index = 0;
  List<TextModel>? model;
  var isLoaded = false;
  List<String> showreal = [];

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
      for (index; index <= 2;) {
        showreal.add(showText[index]);
        showreal = showreal.reversed.toList();
        index++;
        setState(() {});
      }
    }

    Future.delayed(Duration(seconds: Random().nextInt(15)), () {
      myFunction();
    });
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            reverse: true,
            itemCount: showreal.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext ctxt, int Index) {
              return Container(
                padding:
                    EdgeInsets.only(left: 17, right: 17, top: 10, bottom: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: context.resources.color.colorNormal3,
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      showreal[Index],
                      style: TextStyle(
                          color: context.resources.color.colorDarkest,
                          fontSize: 16),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
