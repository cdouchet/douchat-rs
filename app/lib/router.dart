import 'package:app/modules/home/home.dart';
import 'package:app/views/login.dart';
import 'package:flutter/material.dart';

class DouchatRouter {
  static final DouchatRouter instance = DouchatRouter._internal();

  DouchatRouter._internal();

  Map<String, Widget Function(BuildContext)> buildRoutes() => {
        LoginView.routeName: (context) => const LoginView(),
        Home.routeName: (context) => const Home(),
      };

  Future<T?> push<T extends Object>(
    BuildContext context, {
    required String routeName,
    bool pushAndRemove = true,
  }) {
    return Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => buildRoutes()[routeName]!(context),
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (_, a, ___, c) => FadeTransition(
            opacity: a.drive(CurveTween(curve: Curves.easeOutCubic)),
            child: c,
          ),
        ),
        (route) => !pushAndRemove);
  }
}
