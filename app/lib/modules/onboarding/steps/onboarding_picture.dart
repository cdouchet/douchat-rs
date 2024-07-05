import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class OnboardingPicture extends StatelessWidget {
  final FilePickerResult result;
  const OnboardingPicture({super.key, required this.result});

  Future<List<int>> get convertedFuture => result.files.first.readStream!.reduce((previous, element) => List.from(previous)..addAll(element));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(future: convertedFuture, builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Container();
      }
      final data = Uint8List.fromList(snapshot.data!);
      return CircleAvatar(
        foregroundImage: MemoryImage(data),
      );
    });
  }
}