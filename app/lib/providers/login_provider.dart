import 'dart:async';

import 'package:api/api.dart';
import 'package:app/api/api.dart';
import 'package:app/helpers/device_info.dart';
import 'package:app/main.dart';
import 'package:app/modules/home/home.dart';
import 'package:app/modules/onboarding/onboarding.dart';
import 'package:app/providers/user_provider.dart';
import 'package:app/utils/clair_snackbar.dart';
import 'package:app_links/app_links.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';

final cookieManager = CookieManager(
  PersistCookieJar(
    ignoreExpires: true,
    storage: FileStorage("${applicationDocumentsDirectory.path}/.cookies"),
  ),
);

class LoginProvider extends ChangeNotifier {
  Future<void> signInWithApple(BuildContext context) async {
    SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    ).then((credentials) {
      print("CREDENTIALS: $credentials");
      AppleOauthPayloadBuilder payload = AppleOauthPayloadBuilder();
      payload.idToken = credentials.identityToken!;
      if (credentials.givenName != null) {
        AppleUserBuilder userBuilder = AppleUserBuilder();
        AppleNameBuilder nameBuilder = AppleNameBuilder();
        nameBuilder.firstName = credentials.givenName;
        nameBuilder.lastName = credentials.familyName;
        userBuilder.name = nameBuilder;
        payload.user = userBuilder;
      }
      api
          .getOAuthApi()
          .appleAuth(
            appleOauthPayload: payload.build(),
          )
          .then((loginResponse) {
        if (loginResponse.statusCode == 200) {
          _setUserAndPush(context, loginResponse.data!);
          return;
        }
      }).catchError((err, st) {
        print("Error registering with apple to paper back");
        print(err);
        print(st);
      });
    }).catchError((err, st) {
      print("Error getting apple id credentials");
      print(err);
      print(st);
    });
  }

  Future<void> signInWithGoogle() async {
    try {
      const clientId =
          "542563237932-38e3ra1nlg6gkggkrdk3tp7kv38a977g.apps.googleusercontent.com";
      final redirectUri = "$apiUrl/login/google";
      final url =
          """https://accounts.google.com/o/oauth2/auth/oauthchooseaccount?response_type=code&client_id=$clientId&redirect_uri=$redirectUri&scope=email profile openid&prompt=select_account&state={"isPlatformWeb":false,"isFlutter":true}""";
      print(url);
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      print("");
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  // Listen for incoming app links for login oauth callback
  StreamSubscription<String> listenAppLinks(BuildContext context) {
    final appLinks = AppLinks();
    final subscription = appLinks.stringLinkStream.listen((event) async {
      // Handling Google auth callback
      if (event.contains("google")) {
        final uri = Uri.parse(event);
        final params = uri.queryParameters;
        print("Before loging with google");
        api
            .getOAuthApi()
            .googleAuth(
              code: params['code']!,
              scope: "",
              authuser: "",
              state: "",
              deviceId: await DeviceInfo.instance.getDeviceId(),
            )
            .then((res) {
          print("Success login with google");
          if (res.statusCode == 200) {
            _setUserAndPush(context, res.data!);
            return;
          }
          showCustomSnackbar(context: context, text: "Une erreur est survenue");
        }).catchError((err) {
          showCustomSnackbar(context: context, text: "Une erreur est survenue");
          print("Error handling google auth callback: $err");
        });
      }
    });
    return subscription;
  }

  // Future<void> signInWithGoogle() async {
  //   try {
  //     launchUrl(
  //       Uri.parse(
  //           """https://accounts.google.com/o/oauth2/auth/oauthchooseaccount?response_type=code&client_id=26984179744-dd2nb6nrjtm29368527nu1aec9pg30a3.apps.googleusercontent.com&redirect_uri=https://paper-back.doggo-saloon.net/accounts/login/google&scope=email profile openid&prompt=select_account&state={"isPlatformWeb":false,"isFlutter":true}"""),
  //       mode: LaunchMode.externalApplication,
  //     );
  //     print("");
  //   } catch (e, s) {
  //     print(e);
  //     print(s);
  //   }
  // }

  // Future<void> signInWithGoogle(BuildContext context) async {
  //   GoogleSignIn googleSignIn = GoogleSignIn(
  //     scopes: ["email"],
  //     clientId:
  //         "26984179744-dd2nb6nrjtm29368527nu1aec9pg30a3.apps.googleusercontent.com",
  //     signInOption: SignInOption.standard,
  //   );
  //   final result = await googleSignIn.signIn();
  //   if (result == null) {
  //     showCustomSnackbar(context: context, text: "Une erreur est survenue");
  //     return;
  //   }
  //   api
  //       .getOAuthApi()
  //       .googleAuth(
  //         code: result.serverAuthCode!,
  //         scope: "",
  //         authuser: "",
  //         state: "",
  //       )
  //       .then((res) {
  //     if (res.statusCode == 200) {
  //       _setUserAndPush(context, res.data!);
  //       return;
  //     }
  //   }).catchError((err) {
  //     print("Error signin in with google");
  //     showCustomSnackbar(context: context, text: "Une erreur est survenue");
  //   });
  // }

  void _setUserAndPush(BuildContext context, User user) {
    Provider.of<UserProvider>(context, listen: false).changeUser(user);
    if (!user.onboardingCompleted) {
      Navigator.pushReplacementNamed(context, OnboardingView.routeName);
      return;
    }
    Navigator.pushReplacementNamed(context, Home.routeName);
  }
}
