import 'package:flutter/material.dart';

import '../survey_result.dart';

class SurveyResult extends StatelessWidget {
  final SurveyResultViewModel viewModel;
  final void Function({required String answer}) onSave;

  const SurveyResult({
    required this.viewModel,
    required this.onSave,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return SurveyHeader(viewModel.question);
        }
        final SurveyAnswerViewModel answer = viewModel.answers[index - 1];
        return GestureDetector(
          onTap: () =>
              answer.isCurrentAnswer ? null : onSave(answer: answer.answer),
          child: SurveyAnswer(answer),
        );
      },
      itemCount: viewModel.answers.length + 1,
    );
  }
}
