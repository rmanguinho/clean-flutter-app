import 'package:get/get.dart';

import '../../domain/domain.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';
import '../helpers/helpers.dart';
import '../mixins/mixins.dart';

class GetxSurveyResultPresenter extends GetxController
    with LoadingManager, SessionManager
    implements SurveyResultPresenter {
  final LoadSurveyResult loadSurveyResult;
  final SaveSurveyResult saveSurveyResult;
  final String surveyId;
  final Rx<SurveyResultViewModel?> _surveyResult =
      Rx<SurveyResultViewModel?>(null);

  @override
  Stream<SurveyResultViewModel?> get surveyResultStream => _surveyResult.stream;

  GetxSurveyResultPresenter({
    required this.loadSurveyResult,
    required this.saveSurveyResult,
    required this.surveyId,
  });

  @override
  Future<void> loadData() async {
    await showResultOnAction(
      () => loadSurveyResult.loadBySurvey(surveyId: surveyId),
    );
  }

  @override
  Future<void> save({required String answer}) async {
    await showResultOnAction(() => saveSurveyResult.save(answer: answer));
  }

  Future<void> showResultOnAction(
    Future<SurveyResultEntity> Function() action,
  ) async {
    try {
      isLoading = true;
      final SurveyResultEntity surveyResult = await action();
      _surveyResult.subject.add(surveyResult.toViewModel());
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        isSessionExpired = true;
      } else {
        _surveyResult.subject.addError(UIError.unexpected.description);
      }
    } finally {
      isLoading = false;
    }
  }
}
