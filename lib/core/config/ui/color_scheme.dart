import 'package:flutter/material.dart';

abstract class MyColorScheme {
  MyColorScheme._();

  static final ColorScheme falconColorScheme = ColorScheme(
    // 🌑 **Brightness**
    brightness: Brightness.dark,
    // Determines if it's a light or dark theme.

    // 🔴 **Primary Colors (Used for main brand colors)**
    primary: Color(0xFFD32F2F),
    // AppBar, FAB, selection controls, toggle buttons.
    onPrimary: Color(0xFFFFFFFF),
    // Text/icons on top of primary color.

    primaryContainer: Color(0xFFD32F2F),
    // ElevatedButton background, sliders.
    onPrimaryContainer: Color(0xFFFFFFFF),
    // Text/icons inside primaryContainer.

    // ⚫ **Secondary Colors (Used for less dominant UI elements)**
    secondary: Color(0xFF212121),
    // Chips, accent elements.
    onSecondary: Color(0xFFFFFFFF),
    // Text/icons on top of secondary color.

    secondaryContainer: Color(0xFF424242),
    // Background of some buttons/cards.
    onSecondaryContainer: Color(0xFFFFFFFF),
    // Text/icons inside secondaryContainer.

    // ⚪ **Tertiary Colors (Additional Accents)**
    tertiary: Color(0xFFFFFFFF),
    // Used for highlights, special UI elements.
    onTertiary: Color(0xFF000000),
    // Text/icons on top of tertiary color.

    tertiaryContainer: Color(0xFFB0BEC5),
    // Used for backgrounds of tertiary widgets.
    onTertiaryContainer: Color(0xFF000000),
    // Text/icons inside tertiaryContainer.

    // 🏠 **Background & Surface Colors**
    background: Color(0xFF000000),
    // Overall app background.
    onBackground: Color(0xFFFFFFFF),
    // Text/icons on the background.

    // surface: Color(0xFF121212),  // Cards, Dialogs, BottomSheet.
    // onSurface: Color(0xFFFFFFFF),  // Text/icons on surface.

    surface: Color(0xFF212121),
    // Text/icons on surface.
    onSurface: Color(0xFFDDDDDD),

    surfaceVariant: Color(0xFF424242),
    // Secondary surfaces (e.g., dividers, input fields).
    onSurfaceVariant: Color(0xFFE0E0E0),
    // Text/icons inside surfaceVariant.

    // ❌ **Error Colors**
    error: Color(0xFFD32F2F),
    // TextField errors, error banners.
    onError: Color(0xFFFFFFFF),
    // Text/icons on error color.

    errorContainer: Color(0xFFB71C1C),
    // Background of error-related components.
    onErrorContainer: Color(0xFFFFFFFF),
    // Text/icons inside errorContainer.

    // 🔳 **Borders, Shadows, & Miscellaneous**
    outline: Color(0xFF757575),
    // Borders, dividers.
    outlineVariant: Color(0xFFBDBDBD),
    // Secondary outlines.

    shadow: Color(0xFF000000),
    // Shadows on elevated widgets.
    scrim: Color(0xFF000000),
    // Overlay for modal dialogs, drawers.

    // 🔄 **Inverse Colors (For Contrast)**
    inverseSurface: Color(0xFFFFFFFF),
    // Used for contrast in dark themes.
    onInverseSurface: Color(0xFF000000),
    // Text/icons on inverse surface.

    inversePrimary: Color(
        0xFFFFCDD2), // Used for toggles between primary/dark mode.
  );

}
