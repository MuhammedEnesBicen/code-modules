import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';

class LocalStorageService {
  LocalStorageService._NamedCtor() {}
  // Obtain shared preferences.
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;
  static Future<LocalStorageService?> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService._NamedCtor();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  // As an example, storing darkMode status and retrieving it
  // Dark - Light Theme
  static const String _DarkModeKey = 'darkmode';
  set darkMode(dynamic value) => _saveToDisk(_DarkModeKey, value);
  get darkMode => _getFromDisk(_DarkModeKey);

  // Saving Complex data types(Objects) to shared preferences and retrieving it
  static const String _UserKey = 'user';
  set user(User userToSave) => _saveToDisk(_UserKey, json.encode(userToSave.toJson()));
  User get user => return _getFromDisk(_UserKey);
  

  // updated _saveToDisk function that handles all types
  void _saveToDisk<T>(String key, T content) {
    print(
        '(TRACE) LocalStorageService:_saveStringToDisk. key: $key value: $content');
    if (content is String) {
      _preferences!.setString(key, content);
    }
    if (content is bool) {
      _preferences!.setBool(key, content);
    }
    if (content is int) {
      _preferences!.setInt(key, content);
    }
    if (content is double) {
      _preferences!.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences!.setStringList(key, content);
    }
  }

  dynamic _getFromDisk(String key) {
    dynamic value = _preferences!.get(key);
    print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }
}
