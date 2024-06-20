import 'dart:io';

import 'package:app/providers/user_provider.dart';
import 'package:app/router.dart';
import 'package:app/utils/clair_snackbar.dart';
import 'package:app/modules/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

enum LoginButtonType {
  mail,
  apple;

  String pngPath() {
    switch (this) {
      case LoginButtonType.mail:
        return "assets/logos/mail.svg";
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

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        switch (widget.loginButtonType) {
          case LoginButtonType.mail:
            return;
          case LoginButtonType.apple:
            setState(() => isLoading = true);
            Provider.of<UserProvider>(context, listen: false)
                .loginWithApple()
                .then((res) {
              setState(() => isLoading = false);
              if (res.isFailure) {
                showCustomSnackbar(context: context, text: res.failure);
                return;
              }
              DouchatRouter.instance.push(context, routeName: Home.routeName, pushAndRemove: true);
              // Navigator.pushNamedAndRemoveUntil(
              //   context,
              //   Home.routeName,
              //   (route) => false,
              // );
            });
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
