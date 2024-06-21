import 'package:api/api.dart';
import 'package:app/api/api.dart';
import 'package:app/modules/home/home.dart';
import 'package:app/providers/user_provider.dart';
import 'package:app/utils/clair_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginProvider extends ChangeNotifier {
  Future<void> signInWithApple(BuildContext context) async {
    SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    ).then((credentials) {
      print("CREDENTIALS: $credentials");
      AppleUserBuilder userBuilder = AppleUserBuilder();
      userBuilder.email = credentials.email;
      AppleNameBuilder nameBuilder = AppleNameBuilder();
      nameBuilder.firstName = credentials.givenName;
      nameBuilder.lastName = credentials.familyName;
      userBuilder.name = nameBuilder;
      AppleOauthPayloadBuilder payload = AppleOauthPayloadBuilder();
      payload.code = credentials.authorizationCode;
      payload.idToken = credentials.identityToken!;
      payload.state = credentials.state ?? "state";
      payload.user = userBuilder;
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
      const clientId = "542563237932-38e3ra1nlg6gkggkrdk3tp7kv38a977g.apps.googleusercontent.com";
      const redirectUri = "";
      launchUrl(
          Uri.parse(
              """https://accounts.google.com/o/oauth2/auth/oauthchooseaccount?response_type=code&client_id=$clientId&redirect_uri=https://paper-back.doggo-saloon.net/accounts/login/google&scope=email profile openid&prompt=select_account&state={"isPlatformWeb":false,"isFlutter":true}"""),
          mode: LaunchMode.externalApplication);
      print("");
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ["email"],
      clientId:
          "26984179744-dd2nb6nrjtm29368527nu1aec9pg30a3.apps.googleusercontent.com",
      signInOption: SignInOption.standard,
    );
    final result = await googleSignIn.signIn();
    if (result == null) {
      showCustomSnackbar(context: context, text: "Une erreur est survenue");
      return;
    }
    api
        .getOAuthApi()
        .googleAuth(
          code: result.serverAuthCode!,
          scope: "",
          authuser: "",
          state: "",
        )
        .then((res) {
      if (res.statusCode == 200) {
        _setUserAndPush(context, res.data!);
        return;
      }
    }).catchError((err) {
      print("Error signin in with google");
      showCustomSnackbar(context: context, text: "Une erreur est survenue");
    });
  }

  void _setUserAndPush(BuildContext context, User user) {
    Provider.of<UserProvider>(context, listen: false).changeUser(user);
    if (user.username == null) {
      // TODO: Push to onboarding
      return;
    }
    Navigator.pushReplacementNamed(context, Home.routeName);
  }
}
