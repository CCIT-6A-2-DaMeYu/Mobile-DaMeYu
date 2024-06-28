import 'package:dameyu_project/model/login/user_model.dart';
import 'package:flutter/material.dart';


class UserProvider with ChangeNotifier {
  UserModel? _userModel;

  UserModel? get user => _userModel;

  void setUser(UserModel user) {
    _userModel = user;
    notifyListeners();
  }

  void logout() {
    _userModel = null;
    notifyListeners();
  }
}