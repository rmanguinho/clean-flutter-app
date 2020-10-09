import 'package:meta/meta.dart';

import 'survey_result.dart';

class SurveyResultViewModel {
  final String surveyId;
  final String question;
  final List<SurveyAnswerViewModel> answers;

  SurveyResultViewModel({
    @required this.surveyId,
    @required this.question,
    @required this.answers,
  });
}