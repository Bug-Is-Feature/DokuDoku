import 'package:flutter/material.dart';
import 'package:dokudoku/widgets/inputbox.dart';

class SubmitScreen extends StatelessWidget {
  const SubmitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: const [
              SizedBox(
                height: 200,
              ),
              InputBox(),
            ],
          ),
        ),
      ),
    );
  }
}
