import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  ///
  static CacheService? _instance;
  static SharedPreferences? _preferences;

  ///
  CacheService._internal();

  factory CacheService() {
    _instance ??= CacheService._internal();
    return _instance!;
  }

  /// Initialize the cache service
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// Save a value in the cache
  Future<bool> setBool(String key, bool value) async {
    return await _preferences?.setBool(key, value) ?? false;
  }

  /// Save a value in the cache
  Future<bool> setString(String key, String value) async {
    return await _preferences?.setString(key, value) ?? false;
  }

  /// Save a value in the cache
  Future<bool> setStringList(String key, List<String> value) async {
    return await _preferences?.setStringList(key, value) ?? false;
  }

  /// Retrieve a value from the cache
  String? getString(String key) {
    return _preferences?.getString(key);
  }

  /// Retrieve a value from the cache
  List<String>? getStringList(String key) {
    return _preferences?.getStringList(key);
  }

  /// Retrieve a value from the cache
  bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  /// Clear a specific key
  Future<bool> removeValue(String key) async {
    return await _preferences?.remove(key) ?? false;
  }

  /// Clear all cache
  Future<bool> clearCache() async {
    return await _preferences?.clear() ?? false;
  }
}
