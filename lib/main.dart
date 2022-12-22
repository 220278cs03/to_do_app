import 'package:flutter/material.dart';
import 'package:to_do_app/store/store.dart';

import 'page/home_page.dart';
import 'style/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  bool isChangeTheme = true;

  void change() {
    isChangeTheme = !isChangeTheme;
    setState(() {});
  }

  @override
  void initState() {
    getTheme();
    super.initState();
  }

  getTheme() async {
    isChangeTheme = await LocalStore.getTheme();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: isChangeTheme ? ThemeMode.light : ThemeMode.dark,
      theme: ThemeData(
          scaffoldBackgroundColor: Style.whiteColor,
          appBarTheme: AppBarTheme(
              backgroundColor: Style.primaryColor,
              titleTextStyle:
                  Style.textStyleSemiBold(textColor: Style.blackColor)),
          textTheme: TextTheme(
              headline1: Style.textStyleNormal(size: 16),
              headline2: Style.textStyleBold(size: 16))),
      darkTheme: ThemeData(
          scaffoldBackgroundColor: Style.blackColor,
          appBarTheme: AppBarTheme(
              backgroundColor: Style.primaryColor,
              titleTextStyle:
                  Style.textStyleSemiBold(textColor: Style.whiteColor)),
          textTheme: TextTheme(
              headline1:
                  Style.textStyleNormal(size: 16, textColor: Style.blackColor),
              headline2:
                  Style.textStyleBold(size: 16, textColor: Style.whiteColor)),
          checkboxTheme: CheckboxThemeData(
              checkColor: MaterialStateProperty.all(Style.primaryColor),
              fillColor: MaterialStateProperty.all(Style.whiteColor)),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Style.whiteColor,
            labelStyle: TextStyle(color: Style.blackColor),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                borderSide: BorderSide(color: Style.greyColor)),
          )),
      home: HomePage(),
    );
  }
}
