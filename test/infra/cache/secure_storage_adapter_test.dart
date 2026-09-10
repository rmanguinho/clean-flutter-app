import 'package:faker/faker.dart';
import 'package:fordev/infra/infra.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

void main() {
  late SecureStorageAdapter sut;
  late FlutterSecureStorageSpy secureStorage;
  late String key;
  late String value;

  setUp(() {
    key = faker.lorem.word();
    value = faker.guid.guid();
    secureStorage = FlutterSecureStorageSpy();
    secureStorage.mockFetch(value);
    sut = SecureStorageAdapter(secureStorage: secureStorage);
  });

  group('save', () {
    test('Should call save secure with correct values', () async {
      await sut.save(key: key, value: value);

      verify(() => secureStorage.write(key: key, value: value));
    });

    test('Should throw if save secure throws', () async {
      secureStorage.mockSaveError();

      final Future<void> future = sut.save(key: key, value: value);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('fetch', () {
    test('Should call fetch secure with correct value', () async {
      await sut.fetch(key);

      verify(() => secureStorage.read(key: key));
    });

    test('Should return correct value on success', () async {
      final String? fetchedValue = await sut.fetch(key);

      expect(fetchedValue, value);
    });

    test('Should throw if fetch secure throws', () async {
      secureStorage.mockFetchError();

      final Future<String?> future = sut.fetch(key);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('delete', () {
    test('Should call delete with correct key', () async {
      await sut.delete(key);

      verify(() => secureStorage.delete(key: key)).called(1);
    });

    test('Should throw if delete throws', () async {
      secureStorage.mockDeleteError();

      final Future<void> future = sut.delete(key);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });
}
