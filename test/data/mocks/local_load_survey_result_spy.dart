import 'package:fordev/data/usecases/usecases.dart';
import 'package:fordev/domain/entities/entities.dart';
import 'package:fordev/domain/helpers/helpers.dart';

import 'package:mocktail/mocktail.dart';

class LocalLoadSurveyResultSpy extends Mock implements LocalLoadSurveyResult {
  LocalLoadSurveyResultSpy() {
    this.mockValidate();
    this.mockSave();
  }

  When mockLoadCall() => when(() => this.loadBySurvey(surveyId: any(named: 'surveyId')));
  void mockLoad(SurveyResultEntity surveyResult) => this.mockLoadCall().thenAnswer((_) async => surveyResult);
  void mockLoadError() => this.mockLoadCall().thenThrow(DomainError.unexpected);

  When mockValidateCall() => when(() => this.validate(any()));
  void mockValidate() => this.mockValidateCall().thenAnswer((_) async => _);
  void mockValidateError() => this.mockValidateCall().thenThrow(Exception());

  When mockSaveCall() => when(() => this.save(any()));
  void mockSave() => this.mockSaveCall().thenAnswer((_) async => _);
  void mockSaveError() => this.mockSaveCall().thenThrow(Exception());
}