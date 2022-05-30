import 'package:equatable/equatable.dart';

class SurveyAnswerEntity extends Equatable {
  final String? image;
  final String answer;
  final bool isCurrentAnswer;
  final int percent;

  @override
  List<Object?> get props => <Object?>[image, answer, isCurrentAnswer, percent];

  const SurveyAnswerEntity({
    required this.answer,
    required this.percent,
    required this.isCurrentAnswer,
    this.image,
  });
}
