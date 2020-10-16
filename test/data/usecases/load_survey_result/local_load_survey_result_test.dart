import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:ForDev/domain/entities/entities.dart';
import 'package:ForDev/domain/helpers/helpers.dart';
import 'package:ForDev/data/cache/cache.dart';
import 'package:ForDev/data/usecases/usecases.dart';

class CacheStorageSpy extends Mock implements CacheStorage {}

void main() {
  group('loadBySurvey', () {
    LocalLoadSurveyResult sut;
    CacheStorageSpy cacheStorage;
    Map data;
    String surveyId;

    Map mockValidData() => {
      'surveyId': faker.guid.guid(),
      'question': faker.lorem.sentence(),
      'answers': [{
        'image': faker.internet.httpUrl(),
        'answer': faker.lorem.sentence(),
        'isCurrentAnswer': 'true',
        'percent': '40'
      }, {
        'answer': faker.lorem.sentence(),
        'isCurrentAnswer': 'false',
        'percent': '60'
      }],
    };

    PostExpectation mockFetchCall() => when(cacheStorage.fetch(any));

    void mockFetch(Map json) {
      data = json;
      mockFetchCall().thenAnswer((_) async => data);
    }

    void mockFetchError() => mockFetchCall().thenThrow(Exception());

    setUp(() {
      surveyId = faker.guid.guid();
      cacheStorage = CacheStorageSpy();
      sut = LocalLoadSurveyResult(cacheStorage: cacheStorage);
      mockFetch(mockValidData());
    });

    test('Should call cacheStorage with correct key', () async {
      await sut.loadBySurvey(surveyId: surveyId);

      verify(cacheStorage.fetch('survey_result/$surveyId')).called(1);
    });

    test('Should return surveyResult on success', () async {
      final surveyResult = await sut.loadBySurvey(surveyId: surveyId);

      expect(surveyResult, SurveyResultEntity(
        surveyId: data['surveyId'],
        question: data['question'],
        answers: [
          SurveyAnswerEntity(
            image: data['answers'][0]['image'],
            answer: data['answers'][0]['answer'],
            percent: 40,
            isCurrentAnswer: true,
          ),
          SurveyAnswerEntity(
            answer: data['answers'][1]['answer'],
            percent: 60,
            isCurrentAnswer: false,
          )
        ]
      ));
    });

    test('Should throw UnexpectedError if cache is empty', () async {
      mockFetch({});

      final future = sut.loadBySurvey(surveyId: surveyId);

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is null', () async {
      mockFetch(null);

      final future = sut.loadBySurvey(surveyId: surveyId);

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is isvalid', () async {
      mockFetch({
        'surveyId': faker.guid.guid(),
        'question': faker.lorem.sentence(),
        'answers': [{
          'image': faker.internet.httpUrl(),
          'answer': faker.lorem.sentence(),
          'isCurrentAnswer': 'invalid bool',
          'percent': 'invalid int'
        }],
      });

      final future = sut.loadBySurvey(surveyId: surveyId);

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is incomplete', () async {
      mockFetch({
        'surveyId': faker.guid.guid()
      });

      final future = sut.loadBySurvey(surveyId: surveyId);

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache throws', () async {
      mockFetchError();

      final future = sut.loadBySurvey(surveyId: surveyId);

      expect(future, throwsA(DomainError.unexpected));
    });
  });

  group('validate', () {
    LocalLoadSurveyResult sut;
    CacheStorageSpy cacheStorage;
    Map data;
    String surveyId;

    Map mockValidData() => {
      'surveyId': faker.guid.guid(),
      'question': faker.lorem.sentence(),
      'answers': [{
        'image': faker.internet.httpUrl(),
        'answer': faker.lorem.sentence(),
        'isCurrentAnswer': 'true',
        'percent': '40'
      }, {
        'answer': faker.lorem.sentence(),
        'isCurrentAnswer': 'false',
        'percent': '60'
      }],
    };

    PostExpectation mockFetchCall() => when(cacheStorage.fetch(any));

    void mockFetch(Map json) {
      data = json;
      mockFetchCall().thenAnswer((_) async => data);
    }

    void mockFetchError() => mockFetchCall().thenThrow(Exception());

    setUp(() {
      surveyId = faker.guid.guid();
      cacheStorage = CacheStorageSpy();
      sut = LocalLoadSurveyResult(cacheStorage: cacheStorage);
      mockFetch(mockValidData());
    });

    test('Should call cacheStorage with correct key', () async {
      await sut.validate(surveyId);

      verify(cacheStorage.fetch('survey_result/$surveyId')).called(1);
    });

    test('Should delete cache if it is invalid', () async {
      mockFetch({
        'surveyId': faker.guid.guid(),
        'question': faker.lorem.sentence(),
        'answers': [{
          'image': faker.internet.httpUrl(),
          'answer': faker.lorem.sentence(),
          'isCurrentAnswer': 'invalid bool',
          'percent': 'invalid int'
        }],
      });

      await sut.validate(surveyId);

      verify(cacheStorage.delete('survey_result/$surveyId')).called(1);
    });

    test('Should delete cache if it is incomplete', () async {
      mockFetch({
        'surveyId': faker.guid.guid()
      });

      await sut.validate(surveyId);

      verify(cacheStorage.delete('survey_result/$surveyId')).called(1);
    });

    test('Should delete cache if fetch fails', () async {
      mockFetchError();

      await sut.validate(surveyId);

      verify(cacheStorage.delete('survey_result/$surveyId')).called(1);
    });
  });

  group('save', () {
    LocalLoadSurveyResult sut;
    CacheStorageSpy cacheStorage;
    SurveyResultEntity surveyResult;
    String surveyId;

    PostExpectation mockSaveCall() => when(cacheStorage.save(key: anyNamed('key'), value: anyNamed('value')));

    void mockSaveError() => mockSaveCall().thenThrow(Exception());

    SurveyResultEntity mockSurveyResult() => SurveyResultEntity(
      surveyId: faker.guid.guid(),
      question: faker.lorem.sentence(),
      answers: [
        SurveyAnswerEntity(
          image: faker.internet.httpUrl(),
          answer: faker.lorem.sentence(),
          isCurrentAnswer: true,
          percent: 40
        ),
        SurveyAnswerEntity(
          answer: faker.lorem.sentence(),
          isCurrentAnswer: false,
          percent: 60
        )
      ]
    );

    setUp(() {
      surveyId = faker.guid.guid();
      cacheStorage = CacheStorageSpy();
      sut = LocalLoadSurveyResult(cacheStorage: cacheStorage);
      surveyResult = mockSurveyResult();
    });

    test('Should call cacheStorage with correct values', () async {
      Map json = {
        'surveyId': surveyResult.surveyId,
        'question': surveyResult.question,
        'answers': [{
          'image': surveyResult.answers[0].image,
          'answer': surveyResult.answers[0].answer,
          'percent': '40',
          'isCurrentAnswer': 'true'
        }, {
          'image': null,
          'answer': surveyResult.answers[1].answer,
          'percent': '60',
          'isCurrentAnswer': 'false'
        }]
      };

      await sut.save(surveyId: surveyId, surveyResult: surveyResult);

      verify(cacheStorage.save(key: 'survey_result/$surveyId', value: json)).called(1);
    });

    test('Should throw UnexpectedError if save throws', () async {
      mockSaveError();

      final future = sut.save(surveyId: surveyId, surveyResult: surveyResult);

      expect(future, throwsA(DomainError.unexpected));
    });
  });
}