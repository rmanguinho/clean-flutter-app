abstract class SurveyResultPresenter {
  Stream<bool> get isLoadingStream;
  Stream<dynamic> get surveyResultStream;
  
  Future<void> loadData();
}