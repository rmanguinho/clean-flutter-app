import 'package:meta/meta.dart';

import '../../domain/entities/entities.dart';
import 'models.dart';

class LocalSurveyResultModel {
  final String surveyId;
  final String question;
  final List<LocalSurveyAnswerModel> answers;

  LocalSurveyResultModel({
    @required this.surveyId,
    @required this.question,
    @required this.answers,
  });

  factory LocalSurveyResultModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['surveyId', 'question', 'answers'])) {
      throw Exception();
    }
    return LocalSurveyResultModel(
      surveyId: json['surveyId'],
      question: json['question'],
      answers: json['answers'].map<LocalSurveyAnswerModel>((answerJson) => LocalSurveyAnswerModel.fromJson(answerJson)).toList()
    );
  }

  factory LocalSurveyResultModel.fromEntity(SurveyResultEntity entity) => LocalSurveyResultModel(
    surveyId: entity.surveyId,
    question: entity.question,
    answers: entity.answers.map<LocalSurveyAnswerModel>((answer) => LocalSurveyAnswerModel.fromEntity(answer)).toList()
  );

  SurveyResultEntity toEntity() => SurveyResultEntity(
    surveyId: surveyId,
    question: question,
    answers: answers.map<SurveyAnswerEntity>((answer) => answer.toEntity()).toList()
  );

  Map toJson() => {
    'surveyId': surveyId,
    'question': question,
    'answers': answers.map<Map>((answer) => answer.toJson()).toList()
  };
}