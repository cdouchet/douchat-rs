import 'package:app/themes/light/light_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isDisabled;
  bool isLoading;
  ActionButton({
    super.key,
    required this.text,
    required this.isLoading,
    this.onTap,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onTap,
      style: lightActionButtonTheme,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLoading
              ? const CircularProgressIndicator.adaptive()
              : Text(text, style: Theme.of(context).textTheme.labelMedium),
        ],
      ),
    );
  }
}
