import 'dart:io';

import 'package:app/providers/login_provider.dart';
import 'package:app/providers/user_provider.dart';
import 'package:app/router.dart';
import 'package:app/utils/clair_snackbar.dart';
import 'package:app/modules/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

enum LoginButtonType {
  google,
  apple;

  String pngPath() {
    switch (this) {
      case LoginButtonType.google:
        return "assets/logos/google.svg";
      case LoginButtonType.apple:
        return "assets/logos/apple.svg";
    }
  }
}

class LoginButton extends StatefulWidget {
  final LoginButtonType loginButtonType;
  const LoginButton({super.key, required this.loginButtonType});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool isLoading = false;
  Map<LoginButtonType, bool> loadingButtonStates =
      LoginButtonType.values.asMap().map((_, e) => MapEntry(e, false));

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        switch (widget.loginButtonType) {
          case LoginButtonType.google:
            setState(() => loadingButtonStates[LoginButtonType.google] = true);
            Provider.of<LoginProvider>(context, listen: false).signInWithGoogle(context);
            setState(() => loadingButtonStates[LoginButtonType.google] = true);
            return;
          case LoginButtonType.apple:
            setState(() => loadingButtonStates[LoginButtonType.apple] = true);
            Provider.of<LoginProvider>(context, listen: false)
                .signInWithApple(context);
            setState(() => loadingButtonStates[LoginButtonType.apple] = false);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Container(
          height: 30,
          width: 30,
          alignment: Alignment.center,
          child: isLoading
              ? Platform.isIOS
                  ? const CupertinoActivityIndicator(
                      color: Colors.black,
                    )
                  : const CircularProgressIndicator.adaptive()
              : SvgPicture.asset(
                  widget.loginButtonType.pngPath(),
                  color: Colors.black,
                  height: 30,
                ),
        ),
      ),
    );
  }
}
