import 'package:fordev/domain/entities/entities.dart';
import 'package:fordev/domain/helpers/helpers.dart';
import 'package:fordev/data/usecases/usecases.dart';

import '../../../domain/mocks/entity_factory.dart';
import '../../../infra/mocks/mocks.dart';
import '../../mocks/mocks.dart';

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

void main() {
  late LocalLoadSurveys sut;
  late CacheStorageSpy cacheStorage;
  late List<Map> data;
  late List<SurveyEntity> surveys;

  setUp(() {
    surveys = EntityFactory.makeSurveyList();
    data = CacheFactory.makeSurveyList();
    cacheStorage = CacheStorageSpy();
    cacheStorage.mockFetch(data);
    sut = LocalLoadSurveys(cacheStorage: cacheStorage);
  });

  group('load', () {
    test('Should call cacheStorage with correct key', () async {
      await sut.load();

      verify(() => cacheStorage.fetch('surveys')).called(1);
    });

    test('Should return a list of surveys on success', () async {
      final surveys = await sut.load();

      expect(surveys, [
        SurveyEntity(id: data[0]['id'], question: data[0]['question'], dateTime: DateTime.utc(2020, 7, 20), didAnswer: false),
        SurveyEntity(id: data[1]['id'], question: data[1]['question'], dateTime: DateTime.utc(2019, 2, 2), didAnswer: true),
      ]);
    });

    test('Should throw UnexpectedError if cache is empty', () async {
      cacheStorage.mockFetch([]);

      final future = sut.load();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is isvalid', () async {
      cacheStorage.mockFetch(CacheFactory.makeInvalidSurveyList());

      final future = sut.load();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is incomplete', () async {
      cacheStorage.mockFetch(CacheFactory.makeIncompleteSurveyList());

      final future = sut.load();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache throws', () async {
      cacheStorage.mockFetchError();

      final future = sut.load();

      expect(future, throwsA(DomainError.unexpected));
    });
  });

  group('validate', () {
    test('Should call cacheStorage with correct key', () async {
      await sut.validate();

      verify(() => cacheStorage.fetch('surveys')).called(1);
    });

    test('Should delete cache if it is invalid', () async {
      cacheStorage.mockFetch(CacheFactory.makeInvalidSurveyList());

      await sut.validate();

      verify(() => cacheStorage.delete('surveys')).called(1);
    });

    test('Should delete cache if it is incomplete', () async {
      cacheStorage.mockFetch(CacheFactory.makeIncompleteSurveyList());

      await sut.validate();

      verify(() => cacheStorage.delete('surveys')).called(1);
    });

    test('Should delete cache if fetch fails', () async {
      cacheStorage.mockFetchError();

      await sut.validate();

      verify(() => cacheStorage.delete('surveys')).called(1);
    });
  });

  group('save', () {
    test('Should call cacheStorage with correct values', () async {
      final list = [{
        'id': surveys[0].id,
        'question': surveys[0].question,
        'date': '2020-02-02T00:00:00.000Z',
        'didAnswer': 'true',
      }, {
        'id': surveys[1].id,
        'question': surveys[1].question,
        'date': '2018-12-20T00:00:00.000Z',
        'didAnswer': 'false',
      }];

      await sut.save(surveys);

      verify(() => cacheStorage.save(key: 'surveys', value: list)).called(1);
    });

    test('Should throw UnexpectedError if save throws', () async {
      cacheStorage.mockSaveError();

      final future = sut.save(surveys);

      expect(future, throwsA(DomainError.unexpected));
    });
  });
}