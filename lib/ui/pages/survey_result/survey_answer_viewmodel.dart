import 'package:meta/meta.dart';

class SurveyAnswerViewModel {
  final String image;
  final String answer;
  final bool isCurrentAnswer;
  final String percent;

  SurveyAnswerViewModel({
    this.image,
    @required this.answer,
    @required this.isCurrentAnswer,
    @required this.percent,
  });
}