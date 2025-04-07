import 'package:flutter/material.dart';

import '../ui/color_scheme.dart';
import '../ui/my_font_weights.dart';

class ApplicationThemeManager {
  // static ThemeData lightTheme = ThemeData(
  //   useMaterial3: true,
  //   colorScheme: MyColorScheme.falconColorScheme,
  //   primaryColor: MyColorScheme.falconColorScheme.primary,
  //   bottomAppBarTheme: const BottomAppBarTheme(
  //     height: 93,
  //     shape: CircularNotchedRectangle(),
  //   ),
  //   floatingActionButtonTheme: FloatingActionButtonThemeData(
  //     backgroundColor: Colors.white,
  //   ),
  //   scaffoldBackgroundColor: Colors.transparent,
  //   appBarTheme: const AppBarTheme(
  //   ),
  //   textTheme: const TextTheme(
  //     // Title
  //     titleLarge: TextStyle(
  //       fontFamily: "Anton_SC",
  //       fontSize: 30,
  //     ),
  //     titleMedium: TextStyle(
  //       fontFamily: "Anton_SC",
  //       fontSize: 20,
  //     ),
  //
  //     // Body
  //     bodyLarge: TextStyle(
  //       fontFamily: "Anton_SC",
  //       fontSize: 25,
  //     ),
  //     bodyMedium: TextStyle(
  //       fontFamily: "Anton_SC",
  //       fontSize: 20,
  //     ),
  //     bodySmall: TextStyle(
  //       fontFamily: "Anton_SC",
  //       fontSize: 15,
  //     ),
  //
  //     // Display
  //     displayMedium: TextStyle(
  //       fontFamily: "Anton_SC",
  //       fontSize: 16,
  //     ),
  //     displaySmall: TextStyle(
  //       fontFamily: "Anton_SC",
  //       fontSize: 14,
  //     ),
  //
  //   ),
  //   bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
  // );

  static ThemeData myAppTheme = ThemeData(
    useMaterial3: true,
    colorScheme: MyColorScheme.falconColorScheme,
    primaryColor: MyColorScheme.falconColorScheme.primary,
    bottomAppBarTheme: BottomAppBarTheme(
      elevation: 8,
      shape: CircularNotchedRectangle(),
      color: MyColorScheme.falconColorScheme.secondary,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    ),
    filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom()),
    scaffoldBackgroundColor: Color(0xff121212),
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: MyColorScheme.falconColorScheme.secondary,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      // Titles
      titleLarge: TextStyle(
        fontFamily: "Anton_SC",
        fontSize: 28,
        fontWeight: MyFontWeights.bold,
      ),
      titleMedium: TextStyle(
        fontFamily: "Anton_SC",
        fontSize: 22,
        fontWeight: MyFontWeights.semiBold,
      ),

      // Body Texts
      bodyLarge: TextStyle(
        fontFamily: "Anton_SC",
        fontSize: 24,
        fontWeight: MyFontWeights.medium,
      ),
      bodyMedium: TextStyle(
        fontFamily: "Anton_SC",
        fontSize: 18,
        fontWeight: MyFontWeights.regular,
      ),
      bodySmall: TextStyle(
        fontFamily: "Anton_SC",
        fontSize: 16,
        fontWeight: MyFontWeights.light,
      ),

      // Display Texts
      displayMedium: TextStyle(
        fontFamily: "Anton_SC",
        fontSize: 20,
        fontWeight: MyFontWeights.semiBold,
      ),
      displaySmall: TextStyle(
        fontFamily: "Anton_SC",
        fontSize: 18,
        fontWeight: MyFontWeights.regular,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        errorStyle: TextStyle(fontSize: 0),
        hintStyle: TextStyle(color: Color(0xFF616161))
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 2,
      selectedLabelStyle: TextStyle(
        color: MyColorScheme.falconColorScheme.primary,
      ),
      selectedItemColor: MyColorScheme.falconColorScheme.primary,
      backgroundColor: Colors.transparent,
      showUnselectedLabels: false,
      showSelectedLabels: true,
    ),
  );
}
