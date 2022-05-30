import 'package:fordev/ui/pages/pages.dart';

class ViewModelFactory {
  static SurveyResultViewModel makeSurveyResult() =>
      const SurveyResultViewModel(surveyId: 'Any id', question: 'Question', answers: [
        SurveyAnswerViewModel(
            image: 'Image 0',
            answer: 'Answer 0',
            isCurrentAnswer: true,
            percent: '60%'),
        SurveyAnswerViewModel(
            answer: 'Answer 1', isCurrentAnswer: false, percent: '40%')
      ]);

  static List<SurveyViewModel> makeSurveyList() => [
        const SurveyViewModel(
            id: '1', question: 'Question 1', date: 'Date 1', didAnswer: true),
        const SurveyViewModel(
            id: '2', question: 'Question 2', date: 'Date 2', didAnswer: false),
      ];
}
