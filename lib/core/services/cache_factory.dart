import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheFactory {
  static late final SharedPreferences _sharedPreferences;
  static late final FlutterSecureStorage _secureStorage;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _secureStorage = const FlutterSecureStorage();
  }

  /// shared preferences functions

  static dynamic get(String key) {
    return _sharedPreferences.get(key);
  }

  static Future<bool> save(String key, var value) async {
    if (value is String) {
      return await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await _sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      return await _sharedPreferences.setBool(key, value);
    } else {
      return await _sharedPreferences.setDouble(key, value);
    }
  }

  static Future<bool> delete(String key) async {
    return await _sharedPreferences.remove(key);
  }

  /// secure storage functions

  static Future<String?>? getSecuredData(String key) async {
    return await _secureStorage.read(key: key);
  }

  static saveSecuredData(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  static deleteSecuredData() async {
    await _secureStorage.deleteAll();
  }
}
