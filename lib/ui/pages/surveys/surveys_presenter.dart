import './surveys.dart';

abstract class SurveysPresenter {
  Stream<bool> get isLoadingStream;
  Stream<List<SurveyViewModel>> get surveysStream;
  Stream<String> get navigateToStream;

  Future<void> loadData();
  void goToSurveyResult(String surveyId);
}