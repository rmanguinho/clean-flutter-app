import 'package:fordev/domain/domain.dart';

import 'package:mocktail/mocktail.dart';

class LoadSurveyResultSpy extends Mock implements LoadSurveyResult {
  When mockLoadCall() =>
      when(() => loadBySurvey(surveyId: any(named: 'surveyId')));
  void mockLoad(SurveyResultEntity surveyResult) =>
      mockLoadCall().thenAnswer((_) async => surveyResult);
  void mockLoadError(DomainError error) => mockLoadCall().thenThrow(error);
}
