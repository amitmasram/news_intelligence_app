import 'package:flutter/material.dart';

import 'package:news_intelligence_app/core/constants/uiconfigs/themes/text_theme.dart';


class QuickWorkerAppTheme {
  QuickWorkerAppTheme._();

  static ThemeData themeLight = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,

    scaffoldBackgroundColor: Color(0xfff7f9ff),

    primaryColor: Colors.white,
    extensions: <ThemeExtension<dynamic>>[lightCustomTextTheme],
    fontFamily: 'Inter',
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        //foregroundColor: Colorgraphy().kDescentGreyColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            Colors.blue, // Set default background color for ElevatedButtons
        foregroundColor: Colors.white, // Set default text color
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
      ),
    ),
   
    colorScheme: ColorScheme.fromSwatch(
      accentColor: Colors.blue,
      backgroundColor: Colors.white,
      brightness: Brightness.light,
    ),
    dividerTheme: const DividerThemeData(color: Colors.transparent),
  );

}
