import 'package:dokudoku/model/quote.dart';
import 'package:dokudoku/provider/timer_provider.dart';
import 'package:dokudoku/services/quote_service.dart';
import 'package:dokudoku/ui/components/button.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class HourglassView extends StatefulWidget {
  final int id;
  final String title;
  const HourglassView({super.key, required this.id, required this.title});

  @override
  State<HourglassView> createState() => _HourglassViewState();
}

class _HourglassViewState extends State<HourglassView> {
  String quoteBody = '';
  String quoteAuthor = '';
  late Future<Quote> quote = _getQuote();

  Future<Quote> _getQuote() async {
    Quote quote = await QuoteService.getRandomQuote();
    return quote;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerProvider>(context);

    final skipBreakButton = Button(
      onPressed: () {
        Provider.of<TimerProvider>(context, listen: false).pauseHourglass();
        Provider.of<TimerProvider>(context, listen: false)
            .breakTimeDialog(context);
      },
      backgroundColor: context.resources.color.colorDark,
      size: const Size(110, 44),
      child: const Text('Skip Break'),
    );

    final cancelButton = Button(
      onPressed: () {
        Provider.of<TimerProvider>(context, listen: false).pauseHourglass();
        Provider.of<TimerProvider>(context, listen: false)
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
              Text(widget.title.replaceAll('%2520', ' '),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 25)),
              if (provider.currentState == TimerState.focus ||
                  provider.currentState == TimerState.end) ...[
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
                        Provider.of<TimerProvider>(context, listen: false)
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
                        Provider.of<TimerProvider>(context, listen: false)
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
                        Provider.of<TimerProvider>(context, listen: false)
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
                child: provider.currentState == TimerState.focus
                    ? Stack(
                        children: [
                          const ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                            child: RiveAnimation.asset(
                              'assets/images/action_cat.riv',
                              fit: BoxFit.fill,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.18,
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: context.resources.color.colorWhite,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: FutureBuilder<Quote>(
                                future: quote,
                                builder: (BuildContext context,
                                    AsyncSnapshot<Quote> snapshot) {
                                  if (snapshot.hasData) {
                                    quoteBody = snapshot.data!.q;
                                    quoteAuthor = snapshot.data!.a;
                                    Future.delayed(Duration.zero, () {
                                      setState(() async {
                                        quoteBody = snapshot.data!.q;
                                        quoteAuthor = snapshot.data!.a;
                                      });
                                    });
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          quoteBody,
                                          style: const TextStyle(fontSize: 20),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "- $quoteAuthor",
                                          style: const TextStyle(fontSize: 20),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        child: const ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                          child: RiveAnimation.asset(
                            'assets/images/rest_cat.riv',
                            fit: BoxFit.fill,
                          ),
                        ),
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
                  Provider.of<TimerProvider>(context, listen: false)
                      .pauseHourglass();
                  return await Provider.of<TimerProvider>(context,
                          listen: false)
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
