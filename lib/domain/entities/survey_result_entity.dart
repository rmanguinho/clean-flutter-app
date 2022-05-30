import 'package:equatable/equatable.dart';

import './entities.dart';

class SurveyResultEntity extends Equatable {
  final String surveyId;
  final String question;
  final List<SurveyAnswerEntity> answers;

  @override
  List get props => [surveyId, question, answers];

  const SurveyResultEntity({
    required this.surveyId,
    required this.question,
    required this.answers,
  });
}
