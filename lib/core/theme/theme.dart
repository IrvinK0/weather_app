import 'package:flutter/material.dart';

import 'colors.dart';

class FlaconiTheme {
  static ThemeData get light {
    final pallete = LightPallete();
    return ThemeData(
      appBarTheme: AppBarTheme(
        color: pallete.appBar,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
      ),
      scaffoldBackgroundColor: pallete.background,
      textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 17)),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: pallete.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  static ThemeData get dark {
    final pallete = DarkPallete();
    return ThemeData(
      appBarTheme: AppBarTheme(
        color: pallete.appBar,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: Colors.blue,
      ),
      scaffoldBackgroundColor: pallete.background,
      textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 17)),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: pallete.primary.withAlpha(10),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
