import 'package:test/test.dart';
import 'package:api/api.dart';

/// tests for OAuthApi
void main() {
  final instance = Api().getOAuthApi();

  group(OAuthApi, () {
    //Future<User> appleAuth(String code, String idToken, { String state, AppleUser user }) async
    test('test appleAuth', () async {
      // TODO
    });
  });
}
