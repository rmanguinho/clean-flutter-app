import 'survey_viewmodel.dart';

abstract class SurveysPresenter {
  Stream<bool> get isLoadingStream;
  Stream<List<SurveyViewModel>> get loadSurveysStream;

  Future<void> loadData();
}