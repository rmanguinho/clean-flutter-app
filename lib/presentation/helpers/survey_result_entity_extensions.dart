import '../../domain/domain.dart';
import '../../ui/pages/pages.dart';

extension SurveyResultEntityExtensions on SurveyResultEntity {
  SurveyResultViewModel toViewModel() => SurveyResultViewModel(
        surveyId: surveyId,
        question: question,
        answers: answers
            .map((SurveyAnswerEntity answer) => answer.toViewModel())
            .toList(),
      );
}

extension SurveyAnswerEntityExtensions on SurveyAnswerEntity {
  SurveyAnswerViewModel toViewModel() => SurveyAnswerViewModel(
        image: image,
        answer: answer,
        percent: '$percent%',
        isCurrentAnswer: isCurrentAnswer,
      );
}
