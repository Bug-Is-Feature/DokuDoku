import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CompleteShelfView extends StatefulWidget {
  const CompleteShelfView({super.key});

  @override
  State<CompleteShelfView> createState() => _CompleteShelfViewState();
}

class _CompleteShelfViewState extends State<CompleteShelfView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text('Incomplete shelf')],
    );
  }
}
