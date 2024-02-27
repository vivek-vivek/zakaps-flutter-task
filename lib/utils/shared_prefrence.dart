import 'package:shared_preferences/shared_preferences.dart';

final class SharedPreferencesHelper {
  Future clearSharedPrefrence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future setLogin(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("login", value);
  }

  Future getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("login") != null) {
      return prefs.getBool("login");
    }
  }
}
