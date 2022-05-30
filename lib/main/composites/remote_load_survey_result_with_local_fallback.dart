import '../../data/data.dart';
import '../../domain/domain.dart';

class RemoteLoadSurveyResultWithLocalFallback implements LoadSurveyResult {
  final RemoteLoadSurveyResult remote;
  final LocalLoadSurveyResult local;

  RemoteLoadSurveyResultWithLocalFallback({
    required this.remote,
    required this.local,
  });

  @override
  Future<SurveyResultEntity> loadBySurvey({required String surveyId}) async {
    try {
      final SurveyResultEntity surveyResult =
          await remote.loadBySurvey(surveyId: surveyId);
      await local.save(surveyResult);
      return surveyResult;
    } catch (error) {
      if (error == DomainError.accessDenied) {
        rethrow;
      }
      await local.validate(surveyId);
      return await local.loadBySurvey(surveyId: surveyId);
    }
  }
}
