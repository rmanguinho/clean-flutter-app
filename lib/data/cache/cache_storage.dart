abstract class CacheStorage {
  Future<dynamic> fetch(String key);
  Future<void> delete(String key);
}