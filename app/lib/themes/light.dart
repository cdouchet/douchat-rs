import 'package:app/themes/light_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightColorScheme = const ColorScheme.light().copyWith(
  secondary: const Color.fromARGB(255, 234, 234, 234),
  tertiary: const Color.fromARGB(255, 216, 216, 216),
  surface: Colors.black,
  brightness: Brightness.dark,
);

final lightThemeData = ThemeData(
  brightness: Brightness.dark,
  colorScheme: lightColorScheme,
  fontFamily: GoogleFonts.inter().fontFamily,
  elevatedButtonTheme: lightElevatedButtonStyle,
);