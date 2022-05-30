import 'package:faker/faker.dart';
import 'package:fordev/data/data.dart';
import 'package:fordev/domain/domain.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../infra/mocks/mocks.dart';
import '../../mocks/mocks.dart';

void main() {
  late RemoteLoadSurveyResult sut;
  late HttpClientSpy httpClient;
  late String url;
  late Map surveyResult;
  late String surveyId;

  setUp(() {
    surveyResult = ApiFactory.makeSurveyResultJson();
    surveyId = faker.guid.guid();
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    httpClient.mockRequest(surveyResult);
    sut = RemoteLoadSurveyResult(url: url, httpClient: httpClient);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.loadBySurvey(surveyId: surveyId);

    verify(() => httpClient.request(url: url, method: 'get'));
  });

  test('Should return surveyResult on 200', () async {
    final SurveyResultEntity result =
        await sut.loadBySurvey(surveyId: surveyId);

    expect(
      result,
      SurveyResultEntity(
        surveyId: surveyResult['surveyId'],
        question: surveyResult['question'],
        answers: [
          SurveyAnswerEntity(
            image: surveyResult['answers'][0]['image'],
            answer: surveyResult['answers'][0]['answer'],
            isCurrentAnswer: surveyResult['answers'][0]
                ['isCurrentAccountAnswer'],
            percent: surveyResult['answers'][0]['percent'],
          ),
          SurveyAnswerEntity(
            answer: surveyResult['answers'][1]['answer'],
            isCurrentAnswer: surveyResult['answers'][1]
                ['isCurrentAccountAnswer'],
            percent: surveyResult['answers'][1]['percent'],
          )
        ],
      ),
    );
  });

  test(
      'Should throw UnexpectedError if HttpClient returns 200 with invalid data',
      () async {
    httpClient.mockRequest(ApiFactory.makeInvalidJson());

    final Future<SurveyResultEntity> future =
        sut.loadBySurvey(surveyId: surveyId);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    httpClient.mockRequestError(HttpError.notFound);

    final Future<SurveyResultEntity> future =
        sut.loadBySurvey(surveyId: surveyId);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    httpClient.mockRequestError(HttpError.serverError);

    final Future<SurveyResultEntity> future =
        sut.loadBySurvey(surveyId: surveyId);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw AccessDeniedError if HttpClient returns 403', () async {
    httpClient.mockRequestError(HttpError.forbidden);

    final Future<SurveyResultEntity> future =
        sut.loadBySurvey(surveyId: surveyId);

    expect(future, throwsA(DomainError.accessDenied));
  });
}
