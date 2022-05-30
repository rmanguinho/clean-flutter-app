import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../domain/domain.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';
import '../mixins/mixins.dart';

class GetxSurveysPresenter extends GetxController
    with SessionManager, LoadingManager, NavigationManager
    implements SurveysPresenter {
  final LoadSurveys loadSurveys;
  final Rx<List<SurveyViewModel>> _surveys = Rx<List<SurveyViewModel>>([]);

  @override
  Stream<List<SurveyViewModel>> get surveysStream => _surveys.stream;

  GetxSurveysPresenter({required this.loadSurveys});

  @override
  Future<void> loadData() async {
    try {
      isLoading = true;
      final List<SurveyEntity> surveys = await loadSurveys.load();
      _surveys.value = surveys
          .map(
            (SurveyEntity survey) => SurveyViewModel(
              id: survey.id,
              question: survey.question,
              date: DateFormat('dd MMM yyyy').format(survey.dateTime),
              didAnswer: survey.didAnswer,
            ),
          )
          .toList();
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        isSessionExpired = true;
      } else {
        _surveys.subject.addError(UIError.unexpected.description);
      }
    } finally {
      isLoading = false;
    }
  }

  @override
  void goToSurveyResult(String surveyId) {
    navigateTo = '/survey_result/$surveyId';
  }
}
