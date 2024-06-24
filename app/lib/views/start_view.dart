import 'package:app/api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  static const String routeName = "start";

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,

    );
  }
}