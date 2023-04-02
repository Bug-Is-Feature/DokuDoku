import 'package:dokudoku/model/badge.dart' as Badge;
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/ui/components/button.dart';
import 'package:flutter/material.dart';

class BadgeDialog extends StatefulWidget {
  Badge.Badge badge;
  BadgeDialog({super.key, required this.badge});

  @override
  State<BadgeDialog> createState() => _BadgeDialogState();
}

class _BadgeDialogState extends State<BadgeDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        Button(
          child: Text('Ok'),
          onPressed: Navigator.of(context).pop,
          backgroundColor: context.resources.color.colorDarkest,
          size: const Size(84, 30),
        )
      ],
      title: Text(widget.badge.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.badge.description),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
