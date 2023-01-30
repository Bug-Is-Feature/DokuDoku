import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  String title, description, buttonText;
  String? buttonText2;
  VoidCallback onPressed;
  VoidCallback? onPressed2;

  CustomDialog({
    required this.title,
    required this.description,
    required this.buttonText,
    this.buttonText2,
    required this.onPressed,
    this.onPressed2,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            top: 100,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(17),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color.fromARGB(255, 68, 68, 68),
                offset: Offset(0, 6),
                blurRadius: 11,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.description,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30.0),
              Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Color(0xffC78F68),
                        ),
                      ),
                      onPressed: widget.onPressed,
                      child: Text(widget.buttonText),
                    ),
                    if (widget.buttonText2 != null &&
                        widget.onPressed2 != null) ...[
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Color(0xff92603D),
                          ),
                        ),
                        onPressed: widget.onPressed2!,
                        child: Text(widget.buttonText2!),
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
