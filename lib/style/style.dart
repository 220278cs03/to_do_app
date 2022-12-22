import 'package:flutter/material.dart';

abstract class Style {

  Style._();

  // ----------- Color ------------ //
  static const primaryColor = Color(0xffF43F5E);
  //static const primaryDarkColor = Color(0x50);
  static const whiteColor = Colors.white;
  static const blackColor = Colors.black;
  static const transparent = Colors.transparent;
  static const greyColor = Color(0xffEBEEF2);

  // ----------- gradient ------------ //
  static const primaryGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xffFF7E95),
        Color(0xffFF1843),
      ]);

  static const primaryDisableGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0x50FF7E95),
        Color(0x50FF1843),
      ]);

  // ----------- text style ------------ //
  static textStyleNormal({double size = 16, Color textColor = blackColor,bool isDone = false})=>TextStyle(
      fontSize: size,
      color: textColor,
      fontWeight: FontWeight.normal,
      decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none
  );


  static textStyleSemiBold({double size = 18, Color textColor = blackColor})=>TextStyle(
    fontSize: size,
    color: textColor,
    fontWeight: FontWeight.w600,
  );

  static textStyleBold({double size = 18, Color textColor = blackColor})=>TextStyle(
    fontSize: size,
    color: textColor,
    fontWeight: FontWeight.bold,
  );

  static textStyleRegular({double size = 16, Color textColor = blackColor})=>TextStyle(
    fontSize: size,
    color: textColor,
    fontWeight: FontWeight.w400,
  );

}
