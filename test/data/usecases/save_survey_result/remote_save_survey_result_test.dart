import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:ForDev/domain/entities/entities.dart';
import 'package:ForDev/domain/helpers/helpers.dart';
import 'package:ForDev/data/http/http.dart';
import 'package:ForDev/data/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  RemoteSaveSurveyResult sut;
  HttpClientSpy httpClient;
  String url;
  String answer;
  Map surveyResult;

  Map mockValidData() => {
    'surveyId': faker.guid.guid(),
    'question': faker.randomGenerator.string(50),
    'answers': [{
      'image': faker.internet.httpUrl(),
      'answer': faker.randomGenerator.string(20),
      'percent': faker.randomGenerator.integer(100),
      'count': faker.randomGenerator.integer(1000),
      'isCurrentAccountAnswer': faker.randomGenerator.boolean()
    }, {
      'answer': faker.randomGenerator.string(20),
      'percent': faker.randomGenerator.integer(100),
      'count': faker.randomGenerator.integer(1000),
      'isCurrentAccountAnswer': faker.randomGenerator.boolean()
    }],
    'date': faker.date.dateTime().toIso8601String(),
  };

  PostExpectation mockRequest() => when(httpClient.request(
    url: anyNamed('url'),
    method: anyNamed('method'),
    body: anyNamed('body')
  ));

  void mockHttpData(Map data) {
    surveyResult = data;
    mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) => mockRequest().thenThrow(error);

  setUp(() {
    answer = faker.lorem.sentence();
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteSaveSurveyResult(url: url, httpClient: httpClient);
    mockHttpData(mockValidData());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.save(answer: answer);

    verify(httpClient.request(url: url, method: 'put', body: {'answer': answer}));
  });

  test('Should return surveyResult on 200', () async {
    final result = await sut.save(answer: answer);

    expect(result, SurveyResultEntity(
      surveyId: surveyResult['surveyId'],
      question: surveyResult['question'],
      answers: [
        SurveyAnswerEntity(
          image: surveyResult['answers'][0]['image'],
          answer: surveyResult['answers'][0]['answer'],
          isCurrentAnswer: surveyResult['answers'][0]['isCurrentAccountAnswer'],
          percent: surveyResult['answers'][0]['percent'],
        ),
        SurveyAnswerEntity(
          answer: surveyResult['answers'][1]['answer'],
          isCurrentAnswer: surveyResult['answers'][1]['isCurrentAccountAnswer'],
          percent: surveyResult['answers'][1]['percent'],
        )
      ]
    ));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.save(answer: answer);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.save(answer: answer);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw AccessDeniedError if HttpClient returns 403', () async {
    mockHttpError(HttpError.forbidden);

    final future = sut.save(answer: answer);

    expect(future, throwsA(DomainError.accessDenied));
  });
}