import 'package:localstorage/localstorage.dart';
import 'package:mocktail/mocktail.dart';

class LocalStorageSpy extends Mock implements LocalStorage {
  LocalStorageSpy() {
    mockDelete();
    mockSave();
  }

  When mockDeleteCall() => when(() => deleteItem(any()));
  void mockDelete() => mockDeleteCall().thenAnswer((_) async => _);
  void mockDeleteError() => when(() => mockDeleteCall().thenThrow(Exception()));

  When mockSaveCall() => when(() => setItem(any(), any()));
  void mockSave() => mockSaveCall().thenAnswer((_) async => _);
  void mockSaveError() => when(() => mockSaveCall().thenThrow(Exception()));

  When mockFetchCall() => when(() => getItem(any()));
  void mockFetch(dynamic data) => mockFetchCall().thenAnswer((_) async => data);
  void mockFetchError() => when(() => mockFetchCall().thenThrow(Exception()));
}
