import 'dart:convert';

import 'package:api/api.dart';
import 'package:app/api/api.dart';
import 'package:app/modules/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  void changeUser(User user) {
    _user = user;
    notifyListeners();
  }
}