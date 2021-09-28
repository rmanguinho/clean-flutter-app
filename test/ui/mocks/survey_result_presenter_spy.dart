import 'package:fordev/ui/pages/pages.dart';

import 'dart:async';
import 'package:mocktail/mocktail.dart';

class SurveyResultPresenterSpy extends Mock implements SurveyResultPresenter {
  final surveyResultController = StreamController<SurveyResultViewModel?>();
  final isSessionExpiredController = StreamController<bool>();
  final isLoadingController = StreamController<bool>();

  SurveyResultPresenterSpy() {
    when(() => this.loadData()).thenAnswer((_) async => _);
    when(() => this.save(answer: any(named: 'answer'))).thenAnswer((_) async => _);
    when(() => this.surveyResultStream).thenAnswer((_) => surveyResultController.stream);
    when(() => this.isSessionExpiredStream).thenAnswer((_) => isSessionExpiredController.stream);
    when(() => this.isLoadingStream).thenAnswer((_) => isLoadingController.stream);
  }

  void emitSurveyResult(SurveyResultViewModel? data) => surveyResultController.add(data);
  void emitSurveyResultError(String error) => surveyResultController.addError(error);
  void emitLoading([bool show = true]) => isLoadingController.add(show);
  void emitSessionExpired([bool show = true]) => isSessionExpiredController.add(show);

  void dispose() {
    surveyResultController.close();
    isSessionExpiredController.close();
    isLoadingController.close();
  }
}