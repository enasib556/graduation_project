import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<void> saveLoginState() async {
    SharedPrefs prefs = await SharedPrefs.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  static Future<bool> isLoggedIn() async {
    SharedPrefs prefs = await SharedPrefs.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> logout() async {
    SharedPrefs prefs = await SharedPrefs.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }
  
  static getInstance() {}
  
  setBool(String s, bool bool) {}
  
  getBool(String s) {}
}

