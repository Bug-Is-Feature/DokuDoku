import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

ThemeData themeData(BuildContext context) {
  return ThemeData(
    colorScheme: ColorScheme(
        primary: context.resources.color.colorDarkest,
        onPrimary: context.resources.color.colorWhite,
        brightness: Brightness.light,
        secondary: context.resources.color.colorDark,
        onSecondary: context.resources.color.colorWhite,
        background: context.resources.color.colorLightest,
        error: context.resources.color.warning,
        onBackground: context.resources.color.colorDarkest,
        onError: context.resources.color.colorWhite,
        onSurface: context.resources.color.colorNormal2,
        surface: context.resources.color.colorWhite),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 50,
        fontFamily: 'primary',
        fontWeight: FontWeight.bold,
        color: context.resources.color.colorDarkest,
      ),
      headline1: TextStyle(
        fontSize: 30,
        fontFamily: 'primary',
        fontWeight: FontWeight.bold,
        color: context.resources.color.colorDarkest,
      ),
      headline2: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'primary',
          color: context.resources.color.colorDarkest),
      subtitle1: TextStyle(
          fontSize: 20,
          fontFamily: 'primary',
          color: context.resources.color.colorDarkest),
      bodyText1: TextStyle(
          fontSize: 14.0,
          fontFamily: 'primary',
          color: context.resources.color.colorDarkest),
      bodyText2: TextStyle(
          fontSize: 12.0,
          fontFamily: 'primary',
          color: context.resources.color.colorDarkest),
      labelMedium: TextStyle(
          fontSize: 10.0,
          fontFamily: 'primary',
          color: context.resources.color.colorDarkest),
    ),
  );
}
