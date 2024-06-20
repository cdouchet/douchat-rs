import 'package:flutter/material.dart';

class MessageComponent extends StatelessWidget {
  final String sender;
  final String photoUrl;
  final String content;
  final DateTime time;
  const MessageComponent({
    super.key,
    required this.sender,
    required this.photoUrl,
    required this.content,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(43),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            
          ],)
        ],
      ),
    );
  }
}
