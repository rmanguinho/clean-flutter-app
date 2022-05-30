import 'package:equatable/equatable.dart';

class SurveyAnswerEntity extends Equatable {
  final String? image;
  final String answer;
  final bool isCurrentAnswer;
  final int percent;

  List get props => [image, answer, isCurrentAnswer, percent];

  SurveyAnswerEntity({
    this.image,
    required this.answer,
    required this.isCurrentAnswer,
    required this.percent,
  });
}
