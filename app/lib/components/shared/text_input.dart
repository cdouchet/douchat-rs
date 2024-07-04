import 'package:flutter/material.dart';

class DouchatTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  const DouchatTextInput({super.key, required this.controller, this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.bodyMedium,
      cursorColor: Theme.of(context).colorScheme.surface,
      maxLines: 1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        fillColor: Theme.of(context).colorScheme.secondary,
        filled: true,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.6),
            ),
      ),
    );
  }
}
