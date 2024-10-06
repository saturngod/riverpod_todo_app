import 'dart:convert';

import 'package:riverpodtodo/core/utils/preference_name.dart';
import 'package:riverpodtodo/core/utils/storage_manager.dart';

class TokenHelper {

  late final StorageManager storageManager;

  TokenHelper({required this.storageManager});

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
    
    
    storageManager.setString(PreferenceName.token, token);
  }

  Future<void> setRefreshToken(String refreshToken) async{
    storageManager.setString(PreferenceName.refreshToken, refreshToken);
  }

  Future<String?> getAuthToken() async{
    return storageManager.getString(PreferenceName.token);
  }

  Future<String?> getRefreshToken() async{
    return storageManager.getString(PreferenceName.refreshToken);
  }

  void clearToken() {
    storageManager.remove(PreferenceName.token);
    storageManager.remove(PreferenceName.refreshToken);
  }
}