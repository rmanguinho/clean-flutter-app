import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../../composites/composites.dart';
import '../factories.dart';

LoadSurveyResult makeRemoteLoadSurveyResult(String surveyId) => RemoteLoadSurveyResult(
  httpClient: makeAuthorizeHttpClientDecorator(),
  url: makeApiUrl('surveys/$surveyId/results')
);

LoadSurveyResult makeLocalLoadSurveyResult(String surveyId) => LocalLoadSurveyResult(
  cacheStorage: makeLocalStorageAdapter()
);

LoadSurveyResult makeRemoteLoadSurveyResultWithLocalFallback(String surveyId) => RemoteLoadSurveyResultWithLocalFallback(
  remote: makeRemoteLoadSurveyResult(surveyId),
  local: makeLocalLoadSurveyResult(surveyId)
);