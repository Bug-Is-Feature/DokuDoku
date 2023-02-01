import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:flutter/material.dart';

class SnackBarUtils {
  static void showCustomSnackBar({
    required BuildContext context,
    required Color backgroundColor,
    required String content,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(
          content,
          style: TextStyle(
              color: context.resources.color.colorDarkest,
              fontFamily: 'primary',
              fontSize: 16),
        ),
      ),
    );
  }

  static void showSuccessSnackBar({
    required BuildContext context,
    required String content,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: context.resources.color.positive,
        content: Text(
          content,
          style: TextStyle(
              color: context.resources.color.colorWhite,
              fontFamily: 'primary',
              fontSize: 16),
        ),
      ),
    );
  }

  static void showWarningSnackBar({
    required BuildContext context,
    required String content,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: context.resources.color.warning,
        content: Text(
          content,
          style: TextStyle(
              color: context.resources.color.colorDarkest,
              fontFamily: 'primary',
              fontSize: 16),
        ),
      ),
    );
  }
}
