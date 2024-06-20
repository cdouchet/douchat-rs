import 'package:app/themes/light.dart';
import 'package:flutter/material.dart';

final lightElevatedButtonStyle = ElevatedButtonThemeData(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.pressed)) {
          return lightColorScheme.tertiary;
        }
        return lightColorScheme.secondary;
      },
    ),
    foregroundColor: MaterialStatePropertyAll(lightColorScheme.surface),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(24),
      ),
    ),
    splashFactory: NoSplash.splashFactory,
    elevation: const MaterialStatePropertyAll(0),
    shadowColor: const MaterialStatePropertyAll(Colors.transparent),
    surfaceTintColor: const MaterialStatePropertyAll(Colors.transparent),
    overlayColor: const MaterialStatePropertyAll(Colors.transparent)
  ),
);
