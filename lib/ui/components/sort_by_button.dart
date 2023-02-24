import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class SortByButton extends StatefulWidget {
  const SortByButton({super.key});

  @override
  State<SortByButton> createState() => _SortByButtonState();
}

class _SortByButtonState extends State<SortByButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Sorted by ',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(40, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: (() => print('Sorted by title')),
          child: Text(
            'Date added',
            style: TextStyle(fontSize: 14),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.01,
        ),
        GestureDetector(
          onTap: () => print('Ascendning and Descending'),
          child: Icon(
            Icons.swap_vert_rounded,
            color: context.resources.color.colorDarkest,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.015,
        ),
      ],
    );
  }
}
