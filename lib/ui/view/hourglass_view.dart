import 'package:dokudoku/services/quote_dialog.dart';
import 'package:dokudoku/services/timer_service.dart';
import 'package:dokudoku/ui/components/button.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:provider/provider.dart';

class HourglassView extends StatefulWidget {
  const HourglassView({super.key});

  @override
  State<HourglassView> createState() => _HourglassViewState();
}

class _HourglassViewState extends State<HourglassView> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerService>(context);

    final skipBreakButton = Button(
      onPressed: () {
        Provider.of<TimerService>(context, listen: false).pauseHourglass();
        Provider.of<TimerService>(context, listen: false)
            .breakTimeDialog(context);
      },
      backgroundColor: context.resources.color.colorDark,
      size: const Size(110, 44),
      child: const Text('Skip Break'),
    );

    final cancelButton = Button(
      onPressed: () {
        Provider.of<TimerService>(context, listen: false).pauseHourglass();
        Provider.of<TimerService>(context, listen: false)
            .cancelTimeDialog(context: context, isWillPop: false);
      },
      backgroundColor: context.resources.color.error,
      size: const Size(99, 44),
      child: const Text('Cancel'),
    );

    return Scaffold(
      backgroundColor: context.resources.color.colorLightest,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              if (provider.currentState == TimerState.focus ||
                  provider.currentState == TimerState.end) ...[
                // ),
                Text("${provider.iteration}/${provider.inputSessionNum} Rounds",
                    style: const TextStyle(fontSize: 25))
              ] else ...[
                const Text(
                  "Break Time",
                  style: TextStyle(
                    fontSize: 25,
                    color: Color(0xffF96161),
                  ),
                )
              ],
              Divider(
                height: MediaQuery.of(context).size.height * 0.03,
                thickness: 2,
                indent: MediaQuery.of(context).size.width * 0.2,
                endIndent: MediaQuery.of(context).size.width * 0.2,
                color: const Color(0xffC78F68),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Center(
                      child: Text(
                        Provider.of<TimerService>(context, listen: false)
                            .formattedHours(provider.currentDuration),
                        style: const TextStyle(fontSize: 60),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    ":",
                    style: TextStyle(fontSize: 60),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    child: Center(
                      child: Text(
                        Provider.of<TimerService>(context, listen: false)
                            .formattedMinutes(provider.currentDuration),
                        style: const TextStyle(fontSize: 60),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    ":",
                    style: TextStyle(fontSize: 60),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    child: Center(
                      child: Text(
                        Provider.of<TimerService>(context, listen: false)
                            .formattedSeconds(provider.currentDuration),
                        style: const TextStyle(fontSize: 60),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                height: MediaQuery.of(context).size.height * 0.03,
                thickness: 2,
                indent: MediaQuery.of(context).size.width * 0.2,
                endIndent: MediaQuery.of(context).size.width * 0.2,
                color: const Color(0xffC78F68),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                child: QuoteDialog(),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                  color: context.resources.color.colorWhite,
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: [
                    BoxShadow(
                      color: context.resources.color.grey,
                      blurRadius: 5,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (provider.currentState == TimerState.breakTime) ...[
                    skipBreakButton,
                    const SizedBox(
                      width: 30,
                    ),
                    cancelButton,
                  ] else if (provider.currentState == TimerState.focus) ...[
                    cancelButton,
                  ]
                ],
              ),
              WillPopScope(
                child: Container(),
                onWillPop: () async {
                  Provider.of<TimerService>(context, listen: false)
                      .pauseHourglass();
                  return await Provider.of<TimerService>(context, listen: false)
                      .cancelTimeDialog(context: context, isWillPop: true);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
