import 'package:flutter/material.dart';
import 'package:my_pm/core/configs/style/global_colors.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      surface: MyColor.quarterSpanishWhite().color,
      primary: MyColor.bostonBlue().color,
      secondary: MyColor.conch().color,
      inversePrimary: MyColor.kangaroo().color,
    ),
    textTheme: ThemeData.light().textTheme.apply(
          bodyColor: MyColor.friarGray().color,
          displayColor: MyColor.blackPearl().color,
        ));
