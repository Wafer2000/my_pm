import 'package:flutter/material.dart';
import 'package:my_pm/core/configs/style/global_colors.dart';

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: MyColor.pewter().color,
      primary: MyColor.blackPearl().color,
      secondary: MyColor.friarGray().color,
      inversePrimary: MyColor.bitter().color,
    ),
    textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: MyColor.eagle().color,
          displayColor: MyColor.quarterSpanishWhite().color,
        ));
