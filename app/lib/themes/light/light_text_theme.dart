import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle lightDefaultTextStyle = TextStyle(
  fontFamily: GoogleFonts.inter().fontFamily,
);

TextStyle lightTitleLarge = lightDefaultTextStyle.copyWith(
  fontWeight: FontWeight.bold,
  fontSize: 42,
);

TextStyle lightTitleMedium = lightDefaultTextStyle.copyWith(
  fontWeight: FontWeight.w500,
  fontSize: 22
);

TextStyle lightLabelMedium = lightDefaultTextStyle.copyWith(
  fontSize: 17,
  color: Colors.white,
);

TextStyle lightDisplayMedium = lightDefaultTextStyle.copyWith(
  fontSize: 17,
);

TextTheme lightTextTheme = TextTheme(
  titleLarge: lightTitleLarge,
  titleMedium: lightTitleMedium,
  labelMedium: lightLabelMedium,
  displayMedium: lightDisplayMedium,
);