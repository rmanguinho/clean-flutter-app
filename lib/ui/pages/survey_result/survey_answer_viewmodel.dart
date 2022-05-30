import 'package:equatable/equatable.dart';

class SurveyAnswerViewModel extends Equatable {
  final String? image;
  final String answer;
  final bool isCurrentAnswer;
  final String percent;

  @override
  List<Object?> get props => <Object?>[image, answer, isCurrentAnswer, percent];

  const SurveyAnswerViewModel({
    required this.answer,
    required this.isCurrentAnswer,
    required this.percent,
    this.image,
  });
}
