import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../../composites/composites.dart';
import '../factories.dart';

RemoteLoadSurveys makeRemoteLoadSurveys() => RemoteLoadSurveys(
  httpClient: makeAuthorizeHttpClientDecorator(),
  url: makeApiUrl('surveys')
);

LocalLoadSurveys makeLocalLoadSurveys() => LocalLoadSurveys(
  cacheStorage: makeLocalStorageAdapter()
);

LoadSurveys makeRemoteLoadSurveysWithLocalFallback() => RemoteLoadSurveysWithLocalFallback(
  remote: makeRemoteLoadSurveys(),
  local: makeLocalLoadSurveys()
);