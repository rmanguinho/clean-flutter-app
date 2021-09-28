import './survey_result.dart';

import 'package:equatable/equatable.dart';

class SurveyResultViewModel extends Equatable {
  final String surveyId;
  final String question;
  final List<SurveyAnswerViewModel> answers;

  List get props => [surveyId, question, answers];

  SurveyResultViewModel({
    required this.surveyId,
    required this.question,
    required this.answers,
  });
}