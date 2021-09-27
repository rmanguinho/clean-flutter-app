import '../surveys.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurveyItem extends StatelessWidget {
  final SurveyViewModel viewModel;

  SurveyItem(this.viewModel);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SurveysPresenter>(context);
    return GestureDetector(
      onTap: () => presenter.goToSurveyResult(viewModel.id),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: viewModel.didAnswer ? Theme.of(context).secondaryHeaderColor : Theme.of(context).primaryColorDark,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 1),
                spreadRadius: 0,
                blurRadius: 2,
                color: Colors.black
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                viewModel.date,
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                viewModel.question,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}