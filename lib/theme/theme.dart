import 'dart:math';

import 'package:expenses_manager/theme/style.dart';
import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  primaryColor: kPrimaryColor,
  primarySwatch: generateMaterialColor(kPrimaryColor),
  buttonTheme: buttonLightTheme,
  scaffoldBackgroundColor: kScaffoldColor,
  elevatedButtonTheme: elevatedButtonLightTheme,
  appBarTheme: appBarLightTheme,
);

const AppBarTheme appBarLightTheme = AppBarTheme(
    titleTextStyle: TextStyle(color: kTextColor, fontWeight: FontWeight.bold));

const ButtonThemeData buttonLightTheme = ButtonThemeData(
  buttonColor: kAccentColor,
);

ElevatedButtonThemeData elevatedButtonLightTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 3,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        minimumSize: const Size(46, 46)));

TextTheme textLightTheme = const TextTheme();

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);
