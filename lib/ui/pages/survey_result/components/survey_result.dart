import 'package:flutter/material.dart';

import '../survey_result.dart';
import './components.dart';

class SurveyResult extends StatelessWidget {
  final SurveyResultViewModel viewModel;

  SurveyResult(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == 0) {
          return SurveyHeader(viewModel.question);
        }
        return SurveyAnswer(viewModel.answers[index - 1]);
      },
      itemCount: viewModel.answers.length + 1,
    );
  }
}