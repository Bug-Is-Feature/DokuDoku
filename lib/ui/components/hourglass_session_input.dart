import 'package:dokudoku/ui/components/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class HourglassSessionInput extends StatefulWidget {
  const HourglassSessionInput({super.key});

  @override
  State<HourglassSessionInput> createState() => _HourglassSessionInputState();
}

class _HourglassSessionInputState extends State<HourglassSessionInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.48,
            width: MediaQuery.of(context).size.height * 0.45,
            decoration: BoxDecoration(
              color: context.resources.color.colorNormal3,
              boxShadow: [
                BoxShadow(
                  color: context.resources.color.grey,
                  blurRadius: 5,
                  offset: Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 50, 30, 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        'Session Duration',
                        style: TextStyle(fontSize: 25),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 66,
                        height: 35,
                        child: TextField(
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelText: 'Minutes',
                              labelStyle: TextStyle(
                                  color: Color(0xff92603D), fontSize: 15),
                              isDense: true),
                        ),
                      ),
                      // Text('666666')
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      Text('Session', style: TextStyle(fontSize: 25)),
                      Spacer(),
                      SizedBox(
                        width: 66,
                        height: 35,
                        child: TextField(
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(
                                  color: Color(0xff92603D), fontSize: 15),
                              labelText: 'Minutes',
                              isDense: true),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      Text('Break time', style: TextStyle(fontSize: 25)),
                      Spacer(),
                      SizedBox(
                        width: 66,
                        height: 35,
                        child: TextField(
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelText: 'Minutes',
                              labelStyle: TextStyle(
                                  color: Color(0xff92603D), fontSize: 15),
                              isDense: true),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Think again',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Button(
                        child: Text('Confirm'),
                        onPressed: () {},
                        backgroundColor: context.resources.color.colorDark),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
