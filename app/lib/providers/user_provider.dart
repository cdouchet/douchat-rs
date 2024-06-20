import 'dart:convert';

import 'package:app/api/api.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:api/api.dart';
import 'package:result_type/result_type.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:app/main.dart';

final cookieManager = CookieManager(
  PersistCookieJar(
    storage: FileStorage(
      "${applicationDocumentsDirectory.path}/.cookies/"
    ),
    ignoreExpires: true,
  )
);

class UserProvider extends ChangeNotifier {
  late User _user;
  User get user => _user;

  void setUser(User user) {}

  Future<Result<void, String>> loginWithApple() async {
    try {
      final credentials = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ]);
      AppleUserBuilder? user;
      if (credentials.givenName != null) {
        AppleUserBuilder userBuilder = AppleUserBuilder();
        userBuilder.email = credentials.email;
        AppleNameBuilder nameBuilder = AppleNameBuilder();
        nameBuilder.firstName = credentials.givenName;
        nameBuilder.lastName = credentials.familyName;
        userBuilder.name = nameBuilder;
        user = userBuilder;
      }
      AppleOauthPayloadBuilder payload = AppleOauthPayloadBuilder();
      payload.code = credentials.authorizationCode;
      payload.idToken = credentials.identityToken;
      payload.state = credentials.state;
      payload.user = user;
      final res =
          await api.getOAuthApi().appleAuth(appleOauthPayload: payload.build());
      if (res.statusCode == 200) {
        print("Successfully authenticated through apple");
        _user = res.data!;
        return Success(null);
      } else {
        print("Error logging in with apple: ${res.statusCode}");
        return Failure("Une erreur est survenue. Veuillez réessayer plus tard");
      }
    } catch (e, s) {
      print("Fatal error logging in with apple: ");
      print(e);
      print(s);
      return Failure("Une erreur est survenue. Veuillez réessayer plus tard");
    }
  }
}
