import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  String _usernameValue = "";
  String _passwordValue = "";

  String? messageErrorUsernameValue;
  String? messageErrorPasswordValue;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String get usernameValue => _usernameValue;
  String get passwordValue => _passwordValue;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  void setUsernameValue(String value) {
    _usernameValue = value;
    notifyListeners();
  }

  void setPasswordValue(String value) {
    _passwordValue = value;
    notifyListeners();
  }

  void usernameValidator(String value) {
    if (value.isEmpty) {
      messageErrorUsernameValue = "Username tidak boleh kosong!";
    } else {
      messageErrorUsernameValue = null;
    }
    notifyListeners();
  }

  void passwordValidation(String value) {
    if (value.isEmpty) {
      messageErrorPasswordValue = "Password tidak boleh kosong!";
    } else {
      messageErrorPasswordValue = null;
    }
    notifyListeners();
  }
}
