import 'package:fordev/domain/domain.dart';

import 'package:mocktail/mocktail.dart';

class SaveSurveyResultSpy extends Mock implements SaveSurveyResult {
  When mockSaveCall() => when(() => save(answer: any(named: 'answer')));
  void mockSave(SurveyResultEntity data) =>
      mockSaveCall().thenAnswer((_) async => data);
  void mockSaveError(DomainError error) => mockSaveCall().thenThrow(error);
}
