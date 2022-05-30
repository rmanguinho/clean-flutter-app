import 'package:fordev/domain/domain.dart';
import 'package:fordev/main/main.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../data/mocks/mocks.dart';
import '../../domain/mocks/mocks.dart';

void main() {
  late RemoteLoadSurveysWithLocalFallback sut;
  late RemoteLoadSurveysSpy remote;
  late LocalLoadSurveysSpy local;
  late List<SurveyEntity> remoteSurveys;
  late List<SurveyEntity> localSurveys;

  setUp(() {
    localSurveys = EntityFactory.makeSurveyList();
    local = LocalLoadSurveysSpy();
    local.mockLoad(localSurveys);
    remoteSurveys = EntityFactory.makeSurveyList();
    remote = RemoteLoadSurveysSpy();
    remote.mockLoad(remoteSurveys);
    sut = RemoteLoadSurveysWithLocalFallback(remote: remote, local: local);
  });

  test('Should call remote load', () async {
    await sut.load();

    verify(() => remote.load()).called(1);
  });

  test('Should call local save with remote data', () async {
    await sut.load();

    verify(() => local.save(remoteSurveys)).called(1);
  });

  test('Should return remote surveys', () async {
    final List<SurveyEntity> surveys = await sut.load();

    expect(surveys, remoteSurveys);
  });

  test('Should rethrow if remote load throws AccessDeniedError', () async {
    remote.mockLoadError(DomainError.accessDenied);

    final Future<List<SurveyEntity>> future = sut.load();

    expect(future, throwsA(DomainError.accessDenied));
  });

  test('Should call local load on remote error', () async {
    remote.mockLoadError(DomainError.unexpected);

    await sut.load();

    verify(() => local.validate()).called(1);
    verify(() => local.load()).called(1);
  });

  test('Should return local surveys', () async {
    remote.mockLoadError(DomainError.unexpected);

    final List<SurveyEntity> surveys = await sut.load();

    expect(surveys, localSurveys);
  });

  test('Should throw UnexpectedError if remote and local throws', () async {
    remote.mockLoadError(DomainError.unexpected);
    local.mockLoadError();

    final Future<List<SurveyEntity>> future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
