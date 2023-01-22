import 'package:dokudoku/ui/components/button.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class HourglassSessionInput extends StatefulWidget {
  const HourglassSessionInput({super.key});

  @override
  State<HourglassSessionInput> createState() => _HourglassSessionInputState();
}

class _HourglassSessionInputState extends State<HourglassSessionInput> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.height * 0.45,
            decoration: BoxDecoration(
              color: context.resources.color.colorNormal3,
              boxShadow: [
                BoxShadow(
                  color: context.resources.color.grey,
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 30, 25, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Reading Duration',
                        style: TextStyle(fontSize: 25),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 66,
                        height: 35,
                        child: HourglassInput(
                          onSubmitted: () {},
                          textInputType: TextInputType.number,
                          controller: TextEditingController(),
                          label: 'Minutes',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text('Reading Round',
                          style: TextStyle(fontSize: 25)),
                      const Spacer(),
                      SizedBox(
                        width: 66,
                        height: 35,
                        child: HourglassInput(
                          onSubmitted: () {},
                          textInputType: TextInputType.number,
                          controller: TextEditingController(),
                          label: 'Rounds',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text('Break time', style: TextStyle(fontSize: 25)),
                      const Spacer(),
                      SizedBox(
                        width: 66,
                        height: 35,
                        child: HourglassInput(
                          onSubmitted: () {},
                          textInputType: TextInputType.number,
                          controller: TextEditingController(),
                          label: 'Minutes',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Think again',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Button(
                      child: Text('Confirm'),
                      onPressed: () {},
                      backgroundColor: context.resources.color.colorDark,
                      size: const Size(99, 44),
                    ),
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

class HourglassInput extends StatefulWidget {
  VoidCallback onSubmitted;
  TextEditingController controller;
  TextInputType textInputType;
  String label;
  HourglassInput(
      {required this.onSubmitted,
      required this.controller,
      required this.textInputType,
      required this.label});

  @override
  State<HourglassInput> createState() => HourglassInputState();
}

class HourglassInputState extends State<HourglassInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
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
          labelStyle: TextStyle(color: Color(0xff92603D), fontSize: 15),
          labelText: widget.label,
          isDense: true),
    );
  }
}
