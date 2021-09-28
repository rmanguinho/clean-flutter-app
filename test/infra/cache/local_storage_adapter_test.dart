import 'package:fordev/infra/cache/cache.dart';

import '../mocks/mocks.dart';

import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

void main() {
  late LocalStorageAdapter sut;
  late LocalStorageSpy localStorage;
  late String key;
  late dynamic value;
  late String result;

  setUp(() {
    key = faker.randomGenerator.string(5);
    value = faker.randomGenerator.string(50);
    result = faker.randomGenerator.string(50);
    localStorage = LocalStorageSpy();
    localStorage.mockFetch(result);
    sut = LocalStorageAdapter(localStorage: localStorage);
  });

  group('save', () {
    test('Should call localStorage with correct values', () async {
      await sut.save(key: key, value: value);

      verify(() => localStorage.deleteItem(key)).called(1);
      verify(() => localStorage.setItem(key, value)).called(1);
    });

    test('Should throw if deleteItem throws', () async {
      localStorage.mockDeleteError();

      final future = sut.save(key: key, value: value);

      expect(future, throwsA(TypeMatcher<Exception>()));
    });

    test('Should throw if deleteItem throws', () async {
      localStorage.mockSaveError();
      
      final future = sut.save(key: key, value: value);

      expect(future, throwsA(TypeMatcher<Exception>()));
    });
  });

  group('delete', () {
    test('Should call localStorage with correct values', () async {
      await sut.delete(key);

      verify(() => localStorage.deleteItem(key)).called(1);
    });

    test('Should throw if deleteItem throws', () async {
      localStorage.mockDeleteError();

      final future = sut.delete(key);

      expect(future, throwsA(TypeMatcher<Exception>()));
    });
  });

  group('fetch', () {
    test('Should call localStorage with correct value', () async {
      await sut.fetch(key);

      verify(() => localStorage.getItem(key)).called(1);
    });

    test('Should return same value as localStorage', () async {
      final data = await sut.fetch(key);

      expect(data, result);
    });

    test('Should throw if getItem throws', () async {
      localStorage.mockFetchError();

      final future = sut.fetch(key);

      expect(future, throwsA(TypeMatcher<Exception>()));
    });
  });
}