import 'package:faker/faker.dart';
import 'package:fordev/data/data.dart';
import 'package:fordev/domain/domain.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../domain/mocks/mocks.dart';
import '../../../infra/mocks/mocks.dart';
import '../../mocks/mocks.dart';

void main() {
  late RemoteAddAccount sut;
  late HttpClientSpy httpClient;
  late String url;
  late AddAccountParams params;
  late Map apiResult;

  setUp(() {
    url = faker.internet.httpUrl();
    params = ParamsFactory.makeAddAccount();
    apiResult = ApiFactory.makeAccountJson();
    httpClient = HttpClientSpy();
    httpClient.mockRequest(apiResult);
    sut = RemoteAddAccount(httpClient: httpClient, url: url);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.add(params);

    verify(
      () => httpClient.request(
        url: url,
        method: 'post',
        body: {
          'name': params.name,
          'email': params.email,
          'password': params.password,
          'passwordConfirmation': params.passwordConfirmation
        },
      ),
    );
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    httpClient.mockRequestError(HttpError.badRequest);

    final Future<AccountEntity> future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    httpClient.mockRequestError(HttpError.notFound);

    final Future<AccountEntity> future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    httpClient.mockRequestError(HttpError.serverError);

    final Future<AccountEntity> future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClient returns 403',
      () async {
    httpClient.mockRequestError(HttpError.forbidden);

    final Future<AccountEntity> future = sut.add(params);

    expect(future, throwsA(DomainError.emailInUse));
  });

  test('Should return an Account if HttpClient returns 200', () async {
    final AccountEntity account = await sut.add(params);

    expect(account.token, apiResult['accessToken']);
  });

  test(
      'Should throw UnexpectedError if HttpClient returns 200 with invalid data',
      () async {
    httpClient.mockRequest({'invalid_key': 'invalid_value'});

    final Future<AccountEntity> future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
