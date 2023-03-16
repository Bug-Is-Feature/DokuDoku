import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/services/auth_service.dart';

class AchievementView extends StatefulWidget {
  const AchievementView({super.key});

  @override
  State<AchievementView> createState() => _AchievementViewState();
}

class _AchievementViewState extends State<AchievementView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.resources.color.colorLightest,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            const Text(
              "Achievement",
              style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Container(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: context.resources.color.colorWhite.withOpacity(0.5),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/basic10-nobg.png',
                            width: 100,
                            height: 100,
                          ),
                          Image.asset(
                            'assets/images/basic10-nobg.png',
                            width: 100,
                            height: 100,
                          ),
                          Image.asset(
                            'assets/images/basic10-nobg.png',
                            width: 100,
                            height: 100,
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/basic10-nobg.png',
                            width: 100,
                            height: 100,
                          ),
                          Image.asset(
                            'assets/images/basic10-nobg.png',
                            width: 100,
                            height: 100,
                          ),
                          Image.asset(
                            'assets/images/basic10-nobg.png',
                            width: 100,
                            height: 100,
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/basic10-nobg.png',
                            width: 100,
                            height: 100,
                          ),
                          Image.asset(
                            'assets/images/basic10-nobg.png',
                            width: 100,
                            height: 100,
                          ),
                          Image.asset(
                            'assets/images/basic10-nobg.png',
                            width: 100,
                            height: 100,
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/basic10-nobg.png',
                            width: 100,
                            height: 100,
                          ),
                          Image.asset(
                            'assets/images/basic10-nobg.png',
                            width: 100,
                            height: 100,
                          ),
                          Image.asset(
                            'assets/images/basic10-nobg.png',
                            width: 100,
                            height: 100,
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/basic10-nobg.png',
                            width: 100,
                            height: 100,
                          ),
                          Image.asset(
                            'assets/images/basic10-nobg.png',
                            width: 100,
                            height: 100,
                          ),
                          Image.asset(
                            'assets/images/basic10-nobg.png',
                            width: 100,
                            height: 100,
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
