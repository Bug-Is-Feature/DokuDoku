import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class DetailAchievement extends StatefulWidget {
  const DetailAchievement({super.key});

  @override
  State<DetailAchievement> createState() => _DetailAchievementState();
}

class _DetailAchievementState extends State<DetailAchievement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: context.resources.color.grey,
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
                ' "Lazy Cat" ',
                style: TextStyle(
                    fontSize: 32, color: context.resources.color.greyDarker),
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
              child: Text(
                ' \"The cat who doesn\'t read books every day. ..................................................................................................................................\" ',
                style: TextStyle(
                    fontSize: 16, color: context.resources.color.greyDarker),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.015,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                'Conditions for accepting: Sleep for 1 hourc...................................aaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                style: TextStyle(
                    fontSize: 12, color: context.resources.color.greyDarker),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * -0.15,
            height: 200,
            width: 200,
            child: Image.asset('assets/images/basic10-nobg.png'),
          ),
        ],
      ),
    );
  }
}
