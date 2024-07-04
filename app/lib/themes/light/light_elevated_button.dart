import 'package:app/themes/light/light.dart';
import 'package:flutter/material.dart';

final lightElevatedButtonStyle = ElevatedButtonThemeData(
  style: ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.pressed)) {
          return lightColorScheme.tertiary;
        }
        return lightColorScheme.secondary;
      },
    ),
    foregroundColor: WidgetStatePropertyAll(lightColorScheme.surface),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(24),
      ),
    ),
    splashFactory: NoSplash.splashFactory,
    elevation: const WidgetStatePropertyAll(0),
    shadowColor: const WidgetStatePropertyAll(Colors.transparent),
    surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
  ),
);

final lightActionButtonTheme = lightElevatedButtonStyle.style?.copyWith(
  padding: const WidgetStatePropertyAll(
    EdgeInsets.symmetric(vertical: 16.0),
  ),
  shape: WidgetStatePropertyAll(
    RoundedRectangleBorder(
      side: BorderSide.none,
      borderRadius: BorderRadius.circular(18),
    ),
  ),
  foregroundColor: WidgetStateProperty.resolveWith((states) {
    return Colors.white;
  }),
  backgroundColor: WidgetStateProperty.resolveWith(
    (states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.black.withOpacity(0.2);
      }
      if (states.contains(WidgetState.pressed)) {
        return Colors.black.withOpacity(0.7);
      }
      return Colors.black.withOpacity(0.8);
    },
  ),
);
