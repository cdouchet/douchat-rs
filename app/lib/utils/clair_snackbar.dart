import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showCustomSnackbar({
  required BuildContext context,
  required String text,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide.none,
      ),
    ),
  );
}
