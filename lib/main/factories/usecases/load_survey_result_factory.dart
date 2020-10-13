import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoadSurveyResult makeRemoteLoadSurveyResult(String surveyId) => RemoteLoadSurveyResult(
  httpClient: makeAuthorizeHttpClientDecorator(),
  url: makeApiUrl('surveys/$surveyId/results')
);