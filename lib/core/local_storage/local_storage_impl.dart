import 'package:portfolio/core/local_storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceImpl implements LocalStorage {
  Future<SharedPreferences> get _instance => SharedPreferences.getInstance();

  @override
  Future<void> clear() async {
    final sp = await _instance;
    sp.clear();
  }

  @override
  Future<bool> contains(String key) async {
    final sp = await _instance;
    return sp.containsKey(key);
  }

  @override
  Future<String?> read(String key) async {
    final sp = await _instance;
    return sp.getString(key);
  }

  @override
  Future<void> remove(String key) async {
    final sp = await _instance;
    sp.remove(key);
  }

  @override
  Future<void> write(String key, String value) async {
    final sp = await _instance;
    sp.setString(key, value);
  }

  @override
  Future<void> writeBool(String key, bool value) async {
    final sp = await _instance;
    sp.setBool(key, value);
  }

  @override
  Future<bool?> readBool(String key) async {
    final sp = await _instance;
    return sp.getBool(key);
  }

  @override
  Future<List<String>?> readList(String key) async {
    final sp = await _instance;
    return sp.getStringList(key);
  }

  @override
  Future<void> writeList(String key, List<String> value) async {
    final sp = await _instance;
    sp.setStringList(key, value);
  }
}
