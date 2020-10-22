import 'package:meta/meta.dart';

import 'survey_result.dart';

abstract class SurveyResultPresenter {
  Stream<bool> get isLoadingStream;
  Stream<bool> get isSessionExpiredStream;
  Stream<SurveyResultViewModel> get surveyResultStream;
  
  Future<void> loadData();
  Future<void> save({@required String answer});
}