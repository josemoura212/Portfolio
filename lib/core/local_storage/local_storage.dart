abstract interface class LocalStorage {
  Future<String?> read(String key);
  Future<List<String>?> readList(String key);
  Future<bool?> readBool(String key);
  Future<void> write(String key, String value);
  Future<void> writeList(String key, List<String> value);
  Future<bool> contains(String key);
  Future<void> clear();
  Future<void> remove(String key);
  Future<void> writeBool(String key, bool value);
}
