import 'package:fordev/data/data.dart';
import 'package:fordev/domain/domain.dart';

import 'package:mocktail/mocktail.dart';

class RemoteLoadSurveysSpy extends Mock implements RemoteLoadSurveys {
  When mockLoadCall() => when(() => load());
  void mockLoad(List<SurveyEntity> surveys) =>
      mockLoadCall().thenAnswer((_) async => surveys);
  void mockLoadError(DomainError error) => mockLoadCall().thenThrow(error);
}
