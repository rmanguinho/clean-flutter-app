import 'package:fordev/data/cache/cache.dart';

import 'package:mocktail/mocktail.dart';

class SecureCacheStorageSpy extends Mock implements FetchSecureCacheStorage, DeleteSecureCacheStorage, SaveSecureCacheStorage {
  SecureCacheStorageSpy() {
    this.mockDelete();
    this.mockSave();
  }
  
  When mockFetchCall() => when(() => this.fetch(any()));
  void mockFetch(String? data) => this.mockFetchCall().thenAnswer((_) async => data);
  void mockFetchError() => this.mockFetchCall().thenThrow(Exception());

  When mockDeleteCall() => when(() => this.delete(any()));
  void mockDelete() => this.mockDeleteCall().thenAnswer((_) async => _);
  void mockDeleteError() => this.mockDeleteCall().thenThrow(Exception());

  When mockSaveCall() => when(() => this.save(key: any(named: 'key'), value: any(named: 'value')));
  void mockSave() => this.mockSaveCall().thenAnswer((_) async => _);
  void mockSaveError() => this.mockSaveCall().thenThrow(Exception());
}