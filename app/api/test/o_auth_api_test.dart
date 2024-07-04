import 'package:test/test.dart';
import 'package:api/api.dart';

/// tests for OAuthApi
void main() {
  final instance = Api().getOAuthApi();

  group(OAuthApi, () {
    //Future<User> appleAuth(AppleOauthPayload appleOauthPayload) async
    test('test appleAuth', () async {
      // TODO
    });

    //Future<User> googleAuth(String code, String scope, String authuser, String state, String deviceId) async
    test('test googleAuth', () async {
      // TODO
    });
  });
}
