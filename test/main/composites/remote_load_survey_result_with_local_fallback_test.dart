import 'package:faker/faker.dart';
import 'package:fordev/domain/domain.dart';
import 'package:fordev/main/main.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../data/mocks/mocks.dart';
import '../../domain/domain.dart';

void main() {
  late RemoteLoadSurveyResultWithLocalFallback sut;
  late RemoteLoadSurveyResultSpy remote;
  late LocalLoadSurveyResultSpy local;
  late String surveyId;
  late SurveyResultEntity remoteSurveyResult;
  late SurveyResultEntity localSurveyResult;

  setUp(() {
    surveyId = faker.guid.guid();
    localSurveyResult = EntityFactory.makeSurveyResult();
    local = LocalLoadSurveyResultSpy();
    local.mockLoad(localSurveyResult);
    remoteSurveyResult = EntityFactory.makeSurveyResult();
    remote = RemoteLoadSurveyResultSpy();
    remote.mockLoad(remoteSurveyResult);
    sut = RemoteLoadSurveyResultWithLocalFallback(remote: remote, local: local);
  });

  setUpAll(() {
    registerFallbackValue(EntityFactory.makeSurveyResult());
  });

  test('Should call remote loadBySurvey', () async {
    await sut.loadBySurvey(surveyId: surveyId);

    verify(() => remote.loadBySurvey(surveyId: surveyId)).called(1);
  });

  test('Should call local save with remote data', () async {
    await sut.loadBySurvey(surveyId: surveyId);

    verify(() => local.save(remoteSurveyResult)).called(1);
  });

  test('Should return remote surveyResult', () async {
    final SurveyResultEntity response =
        await sut.loadBySurvey(surveyId: surveyId);

    expect(response, remoteSurveyResult);
  });

  test('Should rethrow if remote loadBySurvey throws AccessDeniedError',
      () async {
    remote.mockLoadError(DomainError.accessDenied);

    final Future<SurveyResultEntity> future =
        sut.loadBySurvey(surveyId: surveyId);

    expect(future, throwsA(DomainError.accessDenied));
  });

  test('Should call local loadBySurvey on remote error', () async {
    remote.mockLoadError(DomainError.unexpected);

    await sut.loadBySurvey(surveyId: surveyId);

    verify(() => local.validate(surveyId)).called(1);
    verify(() => local.loadBySurvey(surveyId: surveyId)).called(1);
  });

  test('Should return local surveyResult', () async {
    remote.mockLoadError(DomainError.unexpected);

    final SurveyResultEntity response =
        await sut.loadBySurvey(surveyId: surveyId);

    expect(response, localSurveyResult);
  });

  test('Should throw UnexpectedError if remote and local loadBySurvey throws',
      () async {
    remote.mockLoadError(DomainError.unexpected);
    local.mockLoadError();

    final Future<SurveyResultEntity> future =
        sut.loadBySurvey(surveyId: surveyId);

    expect(future, throwsA(DomainError.unexpected));
  });
}
