import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  final SharedPreferencesAsync prefs;
  static StorageManager? _instance;

  StorageManager({required this.prefs});
  
  static StorageManager get instance  {
    if (_instance == null) {
      SharedPreferencesAsync pref = SharedPreferencesAsync();
      _instance = StorageManager(prefs: pref);
    }
    return _instance!;
  }

  
  void setString(String key, String value) async{
    await prefs.setString(key, value);
  }

  Future<String?> getString(String key) {
    return prefs.getString(key);
  }

  void remove(String key) async{
    await prefs.remove(key);
  }
}