import 'package:test/test.dart';
import 'package:api/api.dart';

/// tests for LoginApi
void main() {
  final instance = Api().getLoginApi();

  group(LoginApi, () {
    //Future refreshAccessToken() async
    test('test refreshAccessToken', () async {
      // TODO
    });
  });
}
