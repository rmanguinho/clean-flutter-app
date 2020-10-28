import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:ForDev/domain/entities/entities.dart';
import 'package:ForDev/domain/helpers/helpers.dart';
import 'package:ForDev/data/usecases/usecases.dart';
import 'package:ForDev/main/composites/composites.dart';

import '../../mocks/mocks.dart';

class LocalLoadSurveyResultSpy extends Mock implements LocalLoadSurveyResult {}
class RemoteLoadSurveyResultSpy extends Mock implements RemoteLoadSurveyResult {}

void main() {
  RemoteLoadSurveyResultWithLocalFallback sut;
  RemoteLoadSurveyResultSpy remote;
  LocalLoadSurveyResultSpy local;
  String surveyId;
  SurveyResultEntity remoteSurveyResult;
  SurveyResultEntity localSurveyResult;

  PostExpectation mockRemoteLoadBySurveyCall() => when(remote.loadBySurvey(surveyId: anyNamed('surveyId')));

  void mockRemoteLoadBySurvey() {
    remoteSurveyResult = FakeSurveyResultFactory.makeEntity();
    mockRemoteLoadBySurveyCall().thenAnswer((_) async => remoteSurveyResult);
  }

  void mockRemoteLoadBySurveyError(DomainError error) => mockRemoteLoadBySurveyCall().thenThrow(error);

  PostExpectation mockLocalLoadBySurveyCall() => when(local.loadBySurvey(surveyId: anyNamed('surveyId')));

  void mockLocalLoadBySurvey() {
    localSurveyResult = FakeSurveyResultFactory.makeEntity();
    mockLocalLoadBySurveyCall().thenAnswer((_) async => localSurveyResult);
  }

  void mockLocalLoadBySurveyError() => mockLocalLoadBySurveyCall().thenThrow(DomainError.unexpected);

  setUp(() {
    surveyId = faker.guid.guid();
    remote = RemoteLoadSurveyResultSpy();
    local = LocalLoadSurveyResultSpy();
    sut = RemoteLoadSurveyResultWithLocalFallback(
      remote: remote,
      local: local
    );
    mockRemoteLoadBySurvey();
    mockLocalLoadBySurvey();
  });

  test('Should call remote loadBySurvey', () async {
    await sut.loadBySurvey(surveyId: surveyId);

    verify(remote.loadBySurvey(surveyId: surveyId)).called(1);
  });

  test('Should call local save with remote data', () async {
    await sut.loadBySurvey(surveyId: surveyId);

    verify(local.save(remoteSurveyResult)).called(1);
  });

  test('Should return remote surveyResult', () async {
    final response = await sut.loadBySurvey(surveyId: surveyId);

    expect(response, remoteSurveyResult);
  });

  test('Should rethrow if remote loadBySurvey throws AccessDeniedError', () async {
    mockRemoteLoadBySurveyError(DomainError.accessDenied);

    final future = sut.loadBySurvey(surveyId: surveyId);

    expect(future, throwsA(DomainError.accessDenied));
  });

  test('Should call local loadBySurvey on remote error', () async {
    mockRemoteLoadBySurveyError(DomainError.unexpected);

    await sut.loadBySurvey(surveyId: surveyId);

    verify(local.validate(surveyId)).called(1);
    verify(local.loadBySurvey(surveyId: surveyId)).called(1);
  });

  test('Should return local surveyResult', () async {
    mockRemoteLoadBySurveyError(DomainError.unexpected);

    final response = await sut.loadBySurvey(surveyId: surveyId);

    expect(response, localSurveyResult);
  });

  test('Should throw UnexpectedError if remote and local loadBySurvey throws', () async {
    mockRemoteLoadBySurveyError(DomainError.unexpected);
    mockLocalLoadBySurveyError();

    final future = sut.loadBySurvey(surveyId: surveyId);

    expect(future, throwsA(DomainError.unexpected));
  });
}