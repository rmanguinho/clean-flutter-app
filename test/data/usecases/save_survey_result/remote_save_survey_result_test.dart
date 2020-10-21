import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:ForDev/domain/helpers/helpers.dart';
import 'package:ForDev/data/http/http.dart';
import 'package:ForDev/data/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  RemoteSaveSurveyResult sut;
  HttpClientSpy httpClient;
  String url;
  String answer;

  PostExpectation mockRequest() => when(httpClient.request(
    url: anyNamed('url'),
    method: anyNamed('method'),
    body: anyNamed('body')
  ));

  void mockHttpError(HttpError error) => mockRequest().thenThrow(error);

  setUp(() {
    answer = faker.lorem.sentence();
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteSaveSurveyResult(url: url, httpClient: httpClient);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.save(answer: answer);

    verify(httpClient.request(url: url, method: 'put', body: {'answer': answer}));
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