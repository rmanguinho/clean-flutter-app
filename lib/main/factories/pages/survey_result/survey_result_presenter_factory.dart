import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

SurveyResultPresenter makeGetxSurveyResultPresenter(String surveyId) => GetxSurveyResultPresenter(
  loadSurveyResult: makeRemoteLoadSurveyResultWithLocalFallback(surveyId),
  saveSurveyResult: makeRemoteSaveSurveyResult(surveyId),
  surveyId: surveyId
);