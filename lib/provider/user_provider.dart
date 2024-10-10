import 'package:flutter/material.dart';
import 'package:tako_food/model/user.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void cleanUser() {
    _user = null;
    notifyListeners();
  }
}
