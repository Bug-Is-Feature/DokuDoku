import 'package:dokudoku/services/timer_service.dart';
import 'package:dokudoku/ui/components/button.dart';
import 'package:dokudoku/ui/view/hourglass_view.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HourglassSessionInput extends StatefulWidget {
  const HourglassSessionInput({super.key});

  @override
  State<HourglassSessionInput> createState() => _HourglassSessionInputState();
}

class _HourglassSessionInputState extends State<HourglassSessionInput> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerService>(context);

    Widget hourglassInput(
        String text, TextEditingController controller, String label) {
      return Row(
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 25),
          ),
          const Spacer(),
          SizedBox(
            width: 66,
            height: 35,
            child: HourglassInput(
              onSubmitted: (_) =>
                  Provider.of<TimerService>(context).submitData(context),
              keyboardType: const TextInputType.numberWithOptions(
                signed: false,
                decimal: false,
              ),
              inputFormatter: FilteringTextInputFormatter.digitsOnly,
              controller: controller,
              label: label,
            ),
          ),
        ],
      );
    }

    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
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
                        hourglassInput('Reading duration',
                            provider.sessionDurationController, 'Minutes'),
                        const SizedBox(
                          height: 20,
                        ),
                        hourglassInput('Reading Round',
                            provider.sessionIterationController, 'Rounds'),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                        hourglassInput('Break time',
                            provider.breakDurationController, 'Minutes'),
                        const SizedBox(height: 20),
                        const Text(
                          'Think again',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Button(
                            child: Text('Confirm'),
                            onPressed: () {
                              Provider.of<TimerService>(context, listen: false)
                                  .validator(context);
                            },
                            backgroundColor: context.resources.color.colorDark,
                            size: const Size(99, 44),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 8.0),
                      child: Column(
                        children: const [
                          Text(
                            'The maximum for Reading Duration is 1 hour.\nYou need to read for at least 5 minutes to record your history.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class HourglassInput extends StatefulWidget {
  Function(String) onSubmitted;
  TextEditingController controller;
  TextInputType keyboardType;
  TextInputFormatter inputFormatter;
  String label;
  HourglassInput({
    super.key,
    required this.onSubmitted,
    required this.controller,
    required this.keyboardType,
    required this.label,
    required this.inputFormatter,
  });

  @override
  State<HourglassInput> createState() => HourglassInputState();
}

class HourglassInputState extends State<HourglassInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      onSubmitted: widget.onSubmitted,
      inputFormatters: [widget.inputFormatter],
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: context.resources.color.colorWhite,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: context.resources.color.colorWhite,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          filled: true,
          fillColor: context.resources.color.colorWhite,
          border: OutlineInputBorder(),
          labelStyle: TextStyle(color: Color(0xff92603D), fontSize: 15),
          labelText: widget.label,
          isDense: true),
    );
  }
}
