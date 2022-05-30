import 'package:fordev/data/data.dart';
import 'package:fordev/domain/domain.dart';

import 'package:mocktail/mocktail.dart';

class LocalLoadSurveysSpy extends Mock implements LocalLoadSurveys {
  LocalLoadSurveysSpy() {
    mockValidate();
    mockSave();
  }

  When mockLoadCall() => when(() => load());
  void mockLoad(List<SurveyEntity> surveys) =>
      mockLoadCall().thenAnswer((_) async => surveys);
  void mockLoadError() => mockLoadCall().thenThrow(DomainError.unexpected);

  When mockValidateCall() => when(() => validate());
  void mockValidate() => mockValidateCall().thenAnswer((_) async => _);
  void mockValidateError() => mockValidateCall().thenThrow(Exception());

  When mockSaveCall() => when(() => save(any()));
  void mockSave() => mockSaveCall().thenAnswer((_) async => _);
  void mockSaveError() => mockSaveCall().thenThrow(Exception());
}
