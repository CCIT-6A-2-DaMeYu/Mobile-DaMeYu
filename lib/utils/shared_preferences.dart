import 'package:shared_preferences/shared_preferences.dart';

const String keyToken = "token";

class SharedPref {
  Future<void> saveToken(String tokenValue, String text) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(keyToken, tokenValue);
  }

  Future<void> removeToken() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.remove(keyToken);
  }

  Future<String> getToken() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();

    return sharedPref.getString(keyToken) ?? "";
  }
}
