import 'package:fordev/domain/domain.dart';

import 'package:mocktail/mocktail.dart';

class LoadSurveysSpy extends Mock implements LoadSurveys {
  When mockLoadCall() => when(() => load());
  void mockLoad(List<SurveyEntity> surveys) =>
      mockLoadCall().thenAnswer((_) async => surveys);
  void mockLoadError(DomainError error) => mockLoadCall().thenThrow(error);
}
