import 'package:flutter/cupertino.dart';

class NoteHistory extends StatefulWidget {
  const NoteHistory({super.key});

  @override
  State<NoteHistory> createState() => _NoteHistoryState();
}

class _NoteHistoryState extends State<NoteHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Note History'),
    );
  }
}
