import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteHistoryView extends StatefulWidget {
  const NoteHistoryView({super.key});

  @override
  State<NoteHistoryView> createState() => _NoteHistoryViewState();
}

class _NoteHistoryViewState extends State<NoteHistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text('Note History'),
    );
  }
}
