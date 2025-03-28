import 'package:flutter/material.dart';

abstract class MyColorScheme {
  MyColorScheme._();

  static final ColorScheme falconColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFD32F2F),
    // Bold red
    onPrimary: Color(0xFFFFFFFF),
    // White for contrast
    primaryContainer: Color(0xFFB71C1C),
    // Darker red
    onPrimaryContainer: Color(0xFFFFFFFF),

    secondary: Color(0xFF212121),
    // Dark gray/black
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFF424242),
    // Slightly lighter gray
    onSecondaryContainer: Color(0xFFFFFFFF),

    tertiary: Color(0xFFFFFFFF),
    // White accents
    onTertiary: Color(0xFF000000),
    tertiaryContainer: Color(0xFFB0BEC5),
    // Muted grayish tone
    onTertiaryContainer: Color(0xFF000000),

    background: Color(0xFF000000),
    // Black background
    onBackground: Color(0xFFFFFFFF),

    surface: Color(0xFF121212),
    // Dark surface
    onSurface: Color(0xFFFFFFFF),
    surfaceVariant: Color(0xFF424242),
    onSurfaceVariant: Color(0xFFE0E0E0),

    error: Color(0xFFD32F2F),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFB71C1C),
    onErrorContainer: Color(0xFFFFFFFF),

    outline: Color(0xFF757575),
    // Gray for outlines
    outlineVariant: Color(0xFFBDBDBD),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),

    inverseSurface: Color(0xFFFFFFFF),
    onInverseSurface: Color(0xFF000000),
    inversePrimary: Color(0xFFFFCDD2), // Lighter red for contrast
  );
}
