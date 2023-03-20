import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:flutter/material.dart';

ThemeData themeLight = ThemeData(
    primaryColor: colorPurplePrimary,
    scaffoldBackgroundColor: colorWhite,
    appBarTheme: AppBarTheme(backgroundColor: colorPurplePrimary));

ThemeData themeDark = ThemeData(
    primaryColor: colorPurplePrimary,
    scaffoldBackgroundColor: colorPurpleDark,
    textTheme: TextTheme(
        bodyText1: TextStyle(color: colorWhite),
        bodyText2: TextStyle(color: colorWhite)),
    appBarTheme: AppBarTheme(backgroundColor: colorPurpleDark));
