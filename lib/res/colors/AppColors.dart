import 'package:dokudoku/res/colors/BaseColors.dart';
import 'package:flutter/material.dart';

class AppColors implements BaseColors {
  // Theme
  @override
  Color get colorDarkest => Color(0xff92603D);
  @override
  Color get colorDark => Color(0xffC78F68);
  @override
  Color get colorNormal => Color(0xffC79C7D);
  @override
  Color get colorNormal2 => Color(0xffE7C0A3);
  @override
  Color get colorNormal3 => Color(0xffEFD3C2);
  @override
  Color get colorLighter => Color(0xffF1D8C8);
  @override
  Color get colorLighter2 => Color(0xffFEE9CC);
  @override
  Color get colorLightest => Color(0xffFFF5E7);
  @override
  Color get colorWhite => Colors.white;

  //decor color
  @override
  Color get pink => Color(0xffFF897D);
  @override
  Color get purple => Color(0xffAF82F8);
  @override
  Color get blue => Color(0xff67BFC7);

  //sign
  @override
  Color get error => Color(0xffF96161);
  @override
  Color get warning => Color.fromARGB(255, 249, 218, 125);
  @override
  Color get positive => Color(0xff76CC96);

  //Gray Scale
  @override
  Color get greyDarker => Color(0xff6A6A6A);
  @override
  Color get greyDark => Color(0xff909090);
  @override
  Color get grey => Color(0xffCBCBCB);
  @override
  Color get greyLight => Color(0xffE2E2E2);
  @override
  Color get greyLighter => Color(0xffEDEDED);
  @override
  Color get greyLightest => Color(0xffF7F7F7);
}
