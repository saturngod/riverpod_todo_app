import 'dart:convert';

import 'package:riverpodtodo/Utils/preference_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenHelper {
  bool isTokenValid(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return false;

      final payload = json.decode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      );

      final exp = payload['exp'];
      if (exp == null) return false;

      return DateTime.fromMillisecondsSinceEpoch(exp * 1000).isAfter(DateTime.now());
    } catch (_) {
      return false;
    }
  }

  Future<void> setAuthToken(String token) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferenceName.token, token);
  }

  Future<void> setRefreshToken(String refreshToken) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferenceName.refreshToken, refreshToken);
  }

  Future<String?> getAuthToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceName.token);
  }

  Future<String?> getRefreshToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceName.refreshToken);
  }

  Future<void> clearToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(PreferenceName.token);
    prefs.remove(PreferenceName.refreshToken);
  }
}