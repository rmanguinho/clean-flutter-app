import 'package:equatable/equatable.dart';

import './entities.dart';

class SurveyResultEntity extends Equatable {
  final String surveyId;
  final String question;
  final List<SurveyAnswerEntity> answers;

  @override
  List<Object> get props => <Object>[surveyId, question, answers];

  const SurveyResultEntity({
    required this.surveyId,
    required this.question,
    required this.answers,
  });
}
