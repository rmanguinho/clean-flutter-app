import './surveys.dart';

import 'package:flutter/material.dart';

abstract class SurveysPresenter implements Listenable {
  Stream<bool> get isLoadingStream;
  Stream<bool> get isSessionExpiredStream;
  Stream<List<SurveyViewModel>> get surveysStream;
  Stream<String?> get navigateToStream;

  Future<void> loadData();
  void goToSurveyResult(String surveyId);
}