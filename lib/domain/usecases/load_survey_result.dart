import '../entities/entities.dart';

abstract class LoadSurveyResult {
  Future<SurveyResultEntity> loadBySurvey({required String surveyId});
}
